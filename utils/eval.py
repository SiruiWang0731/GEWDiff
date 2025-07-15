# -*- coding: utf-8 -*-
"""
@Author  :   zhwzhong
@License :   (C) Copyright 2013-2018, hit
@Contact :   zhwzhong.hit@gmail.com
@Software:   PyCharm
@File    :   metrics.py
@Time    :   2019/12/4 17:35
@Desc    :
"""
import numpy as np
from scipy.signal import convolve2d
# from skimage.measure import compare_psnr, compare_ssim
from skimage.metrics import structural_similarity as compare_ssim
from skimage.metrics import peak_signal_noise_ratio as compare_psnr

import torch.utils.data as data
from os import listdir
from os.path import join
import scipy.io as scio
import torch
#from niqe import niqe as NIQE

"""
Video Quality Metrics
Copyright (c) 2015 Alex Izvorski <aizvorski@gmail.com>
This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.
This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.
You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
"""

"""
NIQE: Natural Image Quality Evaluator
An excellent no-reference image quality metric.  
Code below is roughly similar on Matlab code graciously provided by Anish Mittal, but is written from scratch (since most of the Matlab functions there don't have numpy equivalents).
Training the model is not implemented yet, so we rely on pre-trained model parameters in file modelparameters.mat.
Cite:
Mittal, Anish, Rajiv Soundararajan, and Alan C. Bovik. "Making a completely blind image quality analyzer." Signal Processing Letters, IEEE 20.3 (2013): 209-212.
"""
import math
import numpy
import numpy.linalg
from scipy.special import gamma
from scipy.ndimage.filters import gaussian_filter
import scipy.io
import skimage.transform


def generalized_gaussian_ratio(alpha):
    return (gamma(2.0/alpha)**2) / (gamma(1.0/alpha) * gamma(3.0/alpha))

def generalized_gaussian_ratio_inverse(k):
    a1 = -0.535707356
    a2 = 1.168939911
    a3 = -0.1516189217
    b1 = 0.9694429
    b2 = 0.8727534
    b3 = 0.07350824
    c1 = 0.3655157
    c2 = 0.6723532
    c3 = 0.033834

    if k < 0.131246:
        return 2 * math.log(27.0/16.0) / math.log(3.0/(4*k**2))
    elif k < 0.448994:
        return (1/(2 * a1)) * (-a2 + math.sqrt(a2**2 - 4*a1*a3 + 4*a1*k))
    elif k < 0.671256:
        return (1/(2*b3*k)) * (b1 - b2*k - math.sqrt((b1 - b2*k)**2 - 4*b3*(k**2)))
    elif k < 0.75:
        safe_value = max((3-4*k)/(4*c1), 1e-6)
        p1 = (c2**2 + 4*c3*math.log(safe_value))
        if p1 < 0:
            print("警告: p1 为负值，设置为 0")
            p1 = 1e-6
        return (1/(2*c3)) * (c2 - math.sqrt(p1))
    else:
        print ("警告: GGRF 逆函数无法计算 %f" %(k))
        return numpy.nan

def estimate_aggd_params(x):
    x_left = x[x < 0]
    x_right = x[x >= 0]
    stddev_left = math.sqrt((1.0/(x_left.size - 1)) * numpy.sum(x_left ** 2))
    stddev_right = math.sqrt((1.0/(x_right.size - 1)) * numpy.sum(x_right ** 2))
    if stddev_right == 0:
        return 1, 0, 0
    r_hat = numpy.mean(numpy.abs(x))**2 / numpy.mean(x**2)
    y_hat = stddev_left / stddev_right
    R_hat = r_hat * (y_hat**3 + 1) * (y_hat + 1) / ((y_hat**2 + 1) ** 2)
    alpha = generalized_gaussian_ratio_inverse(R_hat)
    beta_left = stddev_left * math.sqrt(gamma(3.0/alpha) / gamma(1.0/alpha))
    beta_right = stddev_right * math.sqrt(gamma(3.0/alpha) / gamma(1.0/alpha))
    return alpha, beta_left, beta_right

def compute_features(img_norm):
    features = []
    alpha, beta_left, beta_right = estimate_aggd_params(img_norm)

    features.extend([ alpha, (beta_left+beta_right)/2 ])

    for x_shift, y_shift in ((0,1), (1,0), (1,1), (1,-1)):
        img_pair_products  = img_norm * numpy.roll(numpy.roll(img_norm, y_shift, axis=0), x_shift, axis=1)
        alpha, beta_left, beta_right = estimate_aggd_params(img_pair_products)
        eta = (beta_right - beta_left) * (gamma(2.0/alpha) / gamma(1.0/alpha))
        features.extend([ alpha, eta, beta_left, beta_right ])

    return features

def normalize_image(img, sigma=7/6):
    """
    归一化图像，使用高斯滤波来估算均值和标准差。
    可以尝试不同的 sigma 值来查看影响。
    """
    mu = gaussian_filter(img, sigma, mode='nearest')
    mu_sq = mu * mu
    sigma = numpy.sqrt(numpy.abs(gaussian_filter(img * img, sigma, mode='nearest') - mu_sq))
    
    # 增加一个小值以避免除以零
    img_norm = (img - mu) / (sigma + 1e-6)  # 加入1e-6避免除零
    return img_norm


def NIQE(img):
    model_mat = scipy.io.loadmat('./utils/modelparameters.mat')
    model_mu = model_mat['mu_prisparam']
    model_cov = model_mat['cov_prisparam']

    features = None
    img_scaled = img
    for scale in [1, 2]:
        if scale != 1:
            img_scaled = skimage.transform.rescale(img, 1/scale)

        img_norm = normalize_image(img_scaled)

        scale_features = []
        block_size = 96//scale
        for block_col in range(img_norm.shape[0]//block_size):
            for block_row in range(img_norm.shape[1]//block_size):
                block_features = compute_features( img_norm[block_col*block_size:(block_col+1)*block_size, block_row*block_size:(block_row+1)*block_size] )
                scale_features.append(block_features)

        if features is None:
            features = numpy.vstack(scale_features)
        else:
            features = numpy.hstack([features, numpy.vstack(scale_features)])

    features_mu = numpy.mean(features, axis=0)
    features_cov = numpy.cov(features.T)
    features_cov = numpy.nan_to_num(features_cov, nan=0.0)
    model_cov = numpy.nan_to_num(model_cov, nan=0.0)

    if numpy.isnan(model_cov).any() or numpy.isnan(features_cov).any():
        raise ValueError("协方差矩阵中存在 NaN，可能导致 SVD 失败")
    if numpy.isinf(model_cov).any() or numpy.isinf(features_cov).any():
        raise ValueError("协方差矩阵中存在 Inf，可能导致 SVD 失败")

    try:
        pseudoinv_of_avg_cov  = numpy.linalg.pinv((model_cov + features_cov)/2)
    except numpy.linalg.LinAlgError:
        print("计算协方差矩阵的伪逆时出现错误")
        features_cov = numpy.cov(features.T) + 1e-6 * numpy.eye(features_cov.shape[0])
        pseudoinv_of_avg_cov  = numpy.linalg.pinv((model_cov + features_cov)/2)

    niqe_quality = math.sqrt( (model_mu - features_mu).dot( pseudoinv_of_avg_cov.dot( (model_mu - features_mu).T ) ) )

    return niqe_quality


epsilon = 1e-8
def extract_rgb_from_hyperspectral(hyperspectral_img):
    """
    从高光谱图像中提取指定的波段作为RGB图像
    :param hyperspectral_img: 高光谱图像，形状为 (H, W, C)，H为高度，W为宽度，C为波段数
    :return: RGB图像，形状为 (H, W, 3)
    """
    # 指定需要提取的波段索引（从0开始）
    band_indices = [38, 23, 5]  # 对应高光谱图像的第38, 23, 5波段
    
    # 提取这三波段
    rgb_image = hyperspectral_img[:, :, band_indices]
    
    return rgb_image

def is_image_file(filename):
    return any(filename.endswith(extension) for extension in ['.mat'])


def calculate_niqe(image):
    """
    计算NIQE评分
    :param image: 输入图像，形状为(H, W, C)
    :return: NIQE得分
    """
    # 检查输入图像的形状
   
    niqe_score = np.zeros((image.shape[2],))
    for i in range(image.shape[2]):
        niqe_score[i] = NIQE(image[:, :, i])
    niqe_score = np.mean(niqe_score)
    return niqe_score
    



import torch
import torch.nn as nn
from torchvision.models import inception_v3, Inception_V3_Weights
import numpy as np
from scipy.linalg import sqrtm


def calculate_fid(real_images, generated_images, device='cpu', min_size=128):
    
    def validate_and_prepare(images):
        if isinstance(images, np.ndarray):
            images = torch.from_numpy(images).float().to(device)
        
        if images.ndim == 3:
            images = images.unsqueeze(0)
        if images.shape[1] != 3:
            images = images[:, [38, 23, 5], :, :]
        
        if min(images.shape[2], images.shape[3]) < min_size:
            scale_factor = min_size / min(images.shape[2], images.shape[3])
            new_h = int(images.shape[2] * scale_factor)
            new_w = int(images.shape[3] * scale_factor)
            images = nn.functional.interpolate(images, size=(new_h, new_w), mode='bilinear')
        
        # Normalize to ImageNet mean and std
        mean = torch.tensor([0.485, 0.456, 0.406], device=device)
        std = torch.tensor([0.229, 0.224, 0.225], device=device)
        images = (images - mean[None, :, None, None]) / std[None, :, None, None]
        return images
    
    try:
        weights = Inception_V3_Weights.IMAGENET1K_V1
        inception = inception_v3(weights=weights, transform_input=False).to(device)
        inception.eval()
    except Exception as e:
        print(f"Model initialization failed: {str(e)}")
        return float('inf')
    
    try:
        real_images = validate_and_prepare(real_images)
        gen_images = validate_and_prepare(generated_images)
        
        with torch.no_grad():
            real_features = inception(real_images)[0]
            gen_features = inception(gen_images)[0]
        
        if real_features.ndim == 1:
            real_features = real_features.unsqueeze(0)
        if gen_features.ndim == 1:
            gen_features = gen_features.unsqueeze(0)
            
        if len(real_features) < 2 or len(gen_features) < 2:
            diff = real_features.mean(0) - gen_features.mean(0)
            return diff.dot(diff).item()
        
        mu_real = real_features.mean(dim=0)
        mu_gen = gen_features.mean(dim=0)
        
        # Log the means to inspect
        print(f"mu_real: {mu_real}")
        print(f"mu_gen: {mu_gen}")
        
        eps = 1e-6 * torch.eye(real_features.shape[1], device=device)
        cov_real = torch.cov(real_features.T) + eps
        cov_gen = torch.cov(gen_features.T) + eps
        
        # Log the covariances
        print(f"cov_real: {cov_real}")
        print(f"cov_gen: {cov_gen}")
        
        diff = mu_real - mu_gen
        covmean = sqrtm((cov_real @ cov_gen).cpu().numpy())
        
        if np.iscomplexobj(covmean):
            covmean = covmean.real
        
        # Log the matrix square root
        print(f"covmean: {covmean}")
        
        fid = diff.dot(diff) + torch.trace(cov_real + cov_gen - 2 * torch.from_numpy(covmean).to(device))
        return fid.item()
        
    except Exception as e:
        print(f"FID calculation failed: {str(e)}")
        return float('inf')
from scipy.ndimage import laplace

def laplacian_variance_numpy(image):
    """ 使用 numpy 和 scipy 计算拉普拉斯方差（Laplacian Variance） """
    #gray = np.mean(image, axis=-1)  # 转换为灰度图（适用于 RGB 或 HSI）
    gray = image  # 如果图像已经是灰度图，则不需要转换
    laplacian = laplace(gray)  # 计算拉普拉斯变换
    return np.var(laplacian)  # 计算方差
from scipy.ndimage import sobel

def energy_of_gradient_numpy(image):
    """ 使用 numpy 计算能量梯度（EOG） """
    #gray = np.mean(image, axis=-1)  # 转换为灰度图
    gray = image  # 如果图像已经是灰度图，则不需要转换
    grad_x = sobel(gray, axis=1)  # 计算 x 方向梯度
    grad_y = sobel(gray, axis=0)  # 计算 y 方向梯度
    eog = np.sum(grad_x**2 + grad_y**2)  # 计算梯度能量
    return eog
def hsi_laplacian_variance_numpy(hsi_image):
    """ 计算高光谱图像的拉普拉斯方差（所有波段求均值） """
    lv_scores = [laplacian_variance_numpy(hsi_image[..., i]) for i in range(hsi_image.shape[-1])]
    return np.mean(lv_scores)

def hsi_energy_of_gradient_numpy(hsi_image):
    """ 计算高光谱图像的能量梯度（所有波段求均值） """
    eog_scores = [energy_of_gradient_numpy(hsi_image[..., i]) for i in range(hsi_image.shape[-1])]
    return np.mean(eog_scores)

def compare_ergas(x_true, x_pred, ratio):
    """
    Calculate ERGAS, ERGAS offers a global indication of the quality of fused image.The ideal value is 0.
    :param x_true:
    :param x_pred:
    :param ratio: 上采样系数
    :return:
    """
    x_true, x_pred = img_2d_mat(x_true=x_true, x_pred=x_pred)
    sum_ergas = 0
    for i in range(x_true.shape[0]):
        vec_x = x_true[i]
        vec_y = x_pred[i]
        err = vec_x - vec_y
        r_mse = np.mean(np.power(err, 2))
        tmp = r_mse / ((np.mean(vec_x) + epsilon) ** 2)
        sum_ergas += tmp
    return (100 / ratio) * np.sqrt(sum_ergas / x_true.shape[0])


def compare_sam(x_true, x_pred):
    """
    :param x_true: 高光谱图像：格式：(H, W, C)
    :param x_pred: 高光谱图像：格式：(H, W, C)
    :return: 计算原始高光谱数据与重构高光谱数据的光谱角相似度
    """
    num = 0
    sum_sam = 0
    x_true, x_pred = x_true.astype(np.float32), x_pred.astype(np.float32)
    for x in range(x_true.shape[0]):
        for y in range(x_true.shape[1]):
            tmp_pred = x_pred[x, y].ravel()
            tmp_true = x_true[x, y].ravel()
            if np.linalg.norm(tmp_true) != 0 and np.linalg.norm(tmp_pred) != 0:
                sum_sam += np.arccos(
                    np.inner(tmp_pred, tmp_true) / (np.linalg.norm(tmp_true) * np.linalg.norm(tmp_pred)))
                num += 1
    sam_deg = (sum_sam / num) * 180 / np.pi
    return sam_deg


def compare_corr(x_true, x_pred):
    """
    Calculate the cross correlation between x_pred and x_true.
    求对应波段的相关系数，然后取均值
    CC is a spatial measure.
    """
    x_true, x_pred = img_2d_mat(x_true=x_true, x_pred=x_pred)
    x_true = x_true - np.mean(x_true, axis=1).reshape(-1, 1)
    x_pred = x_pred - np.mean(x_pred, axis=1).reshape(-1, 1)
    numerator = np.sum(x_true * x_pred, axis=1).reshape(-1, 1)
    denominator = np.sqrt(np.sum(x_true * x_true, axis=1) * np.sum(x_pred * x_pred, axis=1)).reshape(-1, 1)
    denominator = denominator + epsilon  # Prevent division by zero

    return (numerator / denominator).mean()


def img_2d_mat(x_true, x_pred):
    """
    # 将三维的多光谱图像转为2位矩阵
    :param x_true: (H, W, C)
    :param x_pred: (H, W, C)
    :return: a matrix which shape is (C, H * W)
    """
    h, w, c = x_true.shape
    x_true, x_pred = x_true.astype(np.float32), x_pred.astype(np.float32)
    x_mat = np.zeros((c, h * w), dtype=np.float32)
    y_mat = np.zeros((c, h * w), dtype=np.float32)
    for i in range(c):
        x_mat[i] = x_true[:, :, i].reshape((1, -1))
        y_mat[i] = x_pred[:, :, i].reshape((1, -1))
    return x_mat, y_mat


def compare_rmse(x_true, x_pred):
    """
    Calculate Root mean squared error
    :param x_true:
    :param x_pred:
    :return:
    """
    x_true, x_pred = x_true.astype(np.float32), x_pred.astype(np.float32)
    return np.linalg.norm(x_true - x_pred) / (np.sqrt(x_true.shape[0] * x_true.shape[1] * x_true.shape[2]))


def mean_squared_error(image_true, image_test, *, multi_channel=False):
    """
    Compute the mean-squared error between two images.
    The mean-squared error is the sum of the squared differences between the
    two images.
    Parameters
    ----------
    image_true : ndarray
        Ground-truth image, same shape as im_test.
    image_test : ndarray
        Test image.
    multi_channel : bool, default=False
        If True, treat the last dimension of the array as channels. Similar
        to `multichannel` in skimage.metrics.mean_squared_error, but this
        function does not support multi-channel images.
    Returns
    -------
    mse : float
        The mean-squared error (MSE) metric.
    """
    if multi_channel:
        raise ValueError("multi_channel is not supported")
    image_true, image_test = np.asarray(image_true), np.asarray(image_test)
    return np.mean((image_true - image_test) ** 2, dtype=np.float64)

def compare_psnr(image_true, image_test, *, data_range=None):
    err = mean_squared_error(image_true, image_test)
    err = np.maximum(err, epsilon)  # Avoid division by zero
    PSNR = 10 * np.log10((data_range ** 2) / err)
    return PSNR

def compare_mpsnr(x_true, x_pred, data_range):
    """
    :param x_true: Input image must have three dimension (H, W, C)
    :param x_pred:
    :return:
    """
    x_true, x_pred = x_true.astype(np.float32), x_pred.astype(np.float32)
    channels = x_true.shape[2]
    total_psnr = [compare_psnr(image_true=x_true[:, :, k], image_test=x_pred[:, :, k], data_range=data_range)
                  for k in range(channels)]

    return np.mean(total_psnr)


def compare_mssim(x_true, x_pred, data_range):
    """
    :param x_true:
    :param x_pred:
    :param data_range:
    :param multidimension:
    :return:
    """
    mssim = [compare_ssim(im1=x_true[:, :, i], im2=x_pred[:, :, i], data_range=data_range)
            for i in range(x_true.shape[2])]

    return np.mean(mssim)


def compare_sid(x_true, x_pred):
    """
    SID is an information theoretic measure for spectral similarity and discriminability.
    :param x_true:
    :param x_pred:
    :return:
    """
    x_true, x_pred = x_true.astype(np.float32), x_pred.astype(np.float32)
    N = x_true.shape[2]
    err = np.zeros(N)
    for i in range(N):
        err[i] = abs(np.sum(x_pred[:, :, i] * np.log10((x_pred[:, :, i] + 1e-3) / (x_true[:, :, i] + 1e-3))) +
                     np.sum(x_true[:, :, i] * np.log10((x_true[:, :, i] + 1e-3) / (x_pred[:, :, i] + 1e-3))))
    return np.mean(err / (x_true.shape[1] * x_true.shape[0]))


def compare_appsa(x_true, x_pred):
    """
    :param x_true:
    :param x_pred:
    :return:
    """
    x_true, x_pred = x_true.astype(np.float32), x_pred.astype(np.float32)
    nom = np.sum(x_true * x_pred, axis=2)
    denom = np.linalg.norm(x_true, axis=2) * np.linalg.norm(x_pred, axis=2)

    cos = np.where((nom / (denom + 1e-3)) > 1, 1, (nom / (denom + 1e-3)))
    appsa = np.arccos(cos)
    return np.sum(appsa) / (x_true.shape[1] * x_true.shape[0])


def compare_mare(x_true, x_pred):
    """
    :param x_true:
    :param x_pred:
    :return:
    """
    x_true, x_pred = x_true.astype(np.float32), x_pred.astype(np.float32)
    diff = x_true - x_pred
    abs_diff = np.abs(diff)
    relative_abs_diff = np.divide(abs_diff, x_true + 1)  # added epsilon to avoid division by zero.
    return np.mean(relative_abs_diff)


def img_qi(img1, img2, block_size=8):
    N = block_size ** 2
    sum2_filter = np.ones((block_size, block_size))

    img1_sq = img1 * img1
    img2_sq = img2 * img2
    img12 = img1 * img2

    img1_sum = convolve2d(img1, np.rot90(sum2_filter), mode='valid')
    img2_sum = convolve2d(img2, np.rot90(sum2_filter), mode='valid')
    img1_sq_sum = convolve2d(img1_sq, np.rot90(sum2_filter), mode='valid')
    img2_sq_sum = convolve2d(img2_sq, np.rot90(sum2_filter), mode='valid')
    img12_sum = convolve2d(img12, np.rot90(sum2_filter), mode='valid')

    img12_sum_mul = img1_sum * img2_sum
    img12_sq_sum_mul = img1_sum * img1_sum + img2_sum * img2_sum
    numerator = 4 * (N * img12_sum - img12_sum_mul) * img12_sum_mul
    denominator1 = N * (img1_sq_sum + img2_sq_sum) - img12_sq_sum_mul
    denominator = denominator1 * img12_sq_sum_mul
    quality_map = np.ones(denominator.shape)
    index = (denominator1 == 0) & (img12_sq_sum_mul != 0)
    quality_map[index] = 2 * img12_sum_mul[index] / img12_sq_sum_mul[index]
    index = (denominator != 0)
    quality_map[index] = numerator[index] / denominator[index]
    return quality_map.mean()


def compare_qave(x_true, x_pred, block_size=8):
    n_bands = x_true.shape[2]
    q_orig = np.zeros(n_bands)
    for idim in range(n_bands):
        q_orig[idim] = img_qi(x_true[:, :, idim], x_pred[:, :, idim], block_size)
    return q_orig.mean()


def quality_assessment(x_true, x_pred, data_range, ratio, multi_dimension=False, block_size=8):
    """
    :param multi_dimension:
    :param ratio:
    :param data_range:
    :param x_true:
    :param x_pred:
    :param block_size
    :return:
    """
    rgb_true = extract_rgb_from_hyperspectral(x_true)
    rgb_pred = extract_rgb_from_hyperspectral(x_pred)

    # 计算NIQE
    #niqe_true = calculate_niqe(rgb_true)
    #niqe_pred = calculate_niqe(rgb_pred)
    
    # 计算FID
    fid = calculate_fid(rgb_true, rgb_pred)
    # 计算拉普拉斯方差
    lv_true = hsi_laplacian_variance_numpy(x_true)
    lv_pred = hsi_laplacian_variance_numpy(x_pred)
    
    
    result = {'MPSNR': compare_mpsnr(x_true=x_true, x_pred=x_pred, data_range=data_range),
              'MSSIM': compare_mssim(x_true=x_true, x_pred=x_pred, data_range=data_range),
              #'ERGAS': compare_ergas(x_true=x_true, x_pred=x_pred, ratio=ratio),
              'SAM': compare_sam(x_true=x_true, x_pred=x_pred),
              # 'SID': compare_sid(x_true=x_true, x_pred=x_pred),
              'CrossCorrelation': compare_corr(x_true=x_true, x_pred=x_pred),
              'RMSE': compare_rmse(x_true=x_true, x_pred=x_pred),
              'FID': fid,
                'lv pred': lv_pred,
                'lv true': lv_true,
              # 'APPSA': compare_appsa(x_true=x_true, x_pred=x_pred),
              # 'MARE': compare_mare(x_true=x_true, x_pred=x_pred),
              # "QAVE": compare_qave(x_true=x_true, x_pred=x_pred, block_size=block_size)
              }
    return result

# from scipy import io as sio
# im_out = np.array(sio.loadmat('/home/zhwzhong/PycharmProject/HyperSR/SOAT/HyperSR/SRindices/Chikuse_EDSRViDeCNN_Blocks=9_Feats=256_Loss_H_Real_1_1_X2X2_N5new_BS32_Epo60_epoch_60_Fri_Sep_20_21:38:44_2019.mat')['output'])
# im_gt = np.array(sio.loadmat('/home/zhwzhong/PycharmProject/HyperSR/SOAT/HyperSR/SRindices/Chikusei_test.mat')['gt'])
#
# sum_rmse, sum_sam, sum_psnr, sum_ssim, sum_ergas = [], [], [], [], []
# for i in range(im_gt.shape[0]):
#     print(im_out[i].shape)
#     score = quality_assessment(x_pred=im_out[i], x_true=im_gt[i], data_range=1, ratio=4, multi_dimension=False, block_size=8)
#     sum_rmse.append(score['RMSE'])
#     sum_psnr.append(score['MPSNR'])
#     sum_ssim.append(score['MSSIM'])
#     sum_sam.append(score['SAM'])
#     sum_ergas.append(score['ERGAS'])
#
# print(np.mean(sum_rmse), np.mean(sum_psnr), np.mean(sum_ssim), np.mean(sum_sam))


import numpy as np


def color_correction(lr_input, hr_output, num_channels=31):
    """\n    Perform color correction on the generated HR image to align its mean and variance with those of the LR input.\n    \n    Args:\n    - lr_input: numpy array, shape=(height, width, 3), the LR input image\n    - hr_output: numpy array, shape=(height*scale, width*scale, 3), the generated HR image\n    \n    Returns:\n    - numpy array, shape=(height*scale, width*scale, 3), the color-corrected output image\n    """
    # Calculate mean and standard deviation of each channel in the generated HR image
    hr_mean = np.mean(hr_output, axis=(0, 1))
    hr_std = np.std(hr_output, axis=(0, 1))
    
    # Calculate mean and standard deviation of each channel in the LR input image
    lr_mean = np.mean(lr_input, axis=(0, 1))
    lr_std = np.std(lr_input, axis=(0, 1))
    
    # Perform color correction on each channel
    corrected_output = np.zeros(hr_output.shape, dtype=np.float32)
    for c in range(num_channels):
        corrected_output[:, :, c] = (hr_output[:, :, c] - hr_mean[c]) / hr_std[c] * lr_std[c] + lr_mean[c]
        
    return np.clip(corrected_output, 0.0, 1.0)

def sum_dict(a, b):
    temp = dict()
    for key in a.keys()| b.keys():
        temp[key] = sum([d.get(key, 0) for d in (a, b)])
    return temp

class TestsetFromFolder(data.Dataset):
    def __init__(self, dataset_dir):
        super(TestsetFromFolder, self).__init__()
        self.image_filenames = [join(dataset_dir, x) for x in listdir(dataset_dir) if is_image_file(x)]
        # 把文件先都读取到CPU
        self.img = []
        print("kai shi du qu shu ju ce shi shu ju le")
        for i in range(len(self.image_filenames)):
            print(i)
            mat = scio.loadmat(self.image_filenames[i], verify_compressed_data_integrity=False)
            self.img.append(mat)
        print("gong xi ni !!! shu ju du qu cheng gong le!!!")


    def __getitem__(self, index):
        # mat = scio.loadmat(self.image_filenames[index])
        mat = self.img[index]
        input = mat['LR'].astype(np.float32).transpose(2, 0, 1)
        label = mat['HR'].astype(np.float32).transpose(2, 0, 1)

        input = input[:,:32,:32]
        label = label[:,:128,:128]

        img_HR = torch.from_numpy(label)
        img_LR = torch.from_numpy(input)
        # 这里是上采样了四倍，具体情况改变这个数值。
        # img_LR_1 = img_LR.reshape(1,3,32,32)
        # print(img_LR.shape)
        img_LR_1 = img_LR.reshape(1,102,32,32) # 除了PaviaC数据集，别的都是512，512
        
        img_SR = torch.nn.functional.interpolate(img_LR_1, scale_factor=4, mode='bicubic')

        return {'HR': img_HR, 'SR': img_SR[0], 'LR': img_LR}

    def __len__(self):
        return len(self.image_filenames)

if __name__ == "__main__":
    # pred_list = np.load('./SR3_3_result/Pav_pred_list.npy')
    pred_list = np.load('./Chi4_timetest_list.npy')
    print(len(pred_list))

    result_list = []

    test_num = 64
    channels_3 = 42

    for j in range(test_num):
        indices = [j + i*test_num for i in range(channels_3)]
        print(indices)
        data_list = []
        # for i in indices:
        #     # 直接进行拼接，波段顺序连续
        #     data_list.append(pred_list[i])

        # 每一个里面，存放着间隔的波段,每次循环放一个位置的波段，一共进行三次，复原全部。
        for i in indices:
            # print(pred_list[i][:,:,0][:,:, np.newaxis].shape)
            data_list.append(pred_list[i][:,:,0][:,:, np.newaxis])
        for i in indices:
            data_list.append(pred_list[i][:,:,1][:,:, np.newaxis])
        for i in indices:
            data_list.append(pred_list[i][:,:,2][:,:, np.newaxis])

        # Chikusei 数据集，126通道，把最后俩当作真实的，重复拼接一下。
        data_list.append(pred_list[indices[-1]][:,:,2][:,:, np.newaxis])
        data_list.append(pred_list[indices[-1]][:,:,2][:,:, np.newaxis])

        result = np.concatenate(data_list, axis=-1)
        print(result.shape)
        # result = np.delete(result, -2, axis=-1)
        # result = np.delete(result, -2, axis=-1)
        # print(result.shape)
        result_list.append(result)
    print(len(result_list))


    # 真实数据起初是测试的时候对应的生成，现在更换为真实的样本直接读取。
    # gt_list = np.load('Chi_gt_list.npy')
    # print(len(gt_list))
    # gr_list = []
    # for j in range(4):
    #     indices = [j + i*4 for i in range(42)]
    #     print(indices)
    #     data_list = []
    #     for i in indices:
    #         data_list.append(gt_list[i])
    #     result = np.concatenate(data_list, axis=-1)
    #     # result = np.delete(result, -1, axis=-1)
    #     # result = np.delete(result, -1, axis=-1)
    #     gr_list.append(result)
    # print(len(gr_list))

    val_set = TestsetFromFolder('../Harvard_4_test/')
    # val_set = TestsetFromFolder('../test/Cave/4/4')
    # val_set = TestsetFromFolder('../test/Foster/4/')
    # val_set = TestsetFromFolder('../test/Chikusei/4/')
    # val_set = TestsetFromFolder('../test/PaviaC/4/')
    #val_set = HSTestData(image_dir= '../Chikusei_mat/128test/', n_scale = 4, ch3=False, num_ch=0)
    print(len(val_set))
    gr_list = []
    for mat in val_set:
        gr_list.append(mat['HR'].numpy())


    for idx in range(test_num):
        y = result_list[idx]
        gt = gr_list[idx].transpose(1,2,0)

        # y = y[:128,:128,:]
        # gt = gt[:128,:128,:]
        y = color_correction(gt, y, num_channels=102)

        print(y.shape, gt.shape)
        if idx == 0:
            indices = quality_assessment(gt, y, data_range=1., ratio=4)
        else:
            indices = sum_dict(indices, quality_assessment(gt, y, data_range=1., ratio=4))
        # indices = quality_assessment(gt, y, data_range=1., ratio=4)
        print(indices)
    # 平均一下。
    for index in indices:
        indices[index] = indices[index] / (idx+1)
    print("最终的结果平均指标为 {}".format(indices))
    

    
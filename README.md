# 🌱 CropLit — AI-Powered Crop Disease Detection

**CropLit** is an AI-powered Flutter mobile application for detecting diseases in **Tomato 🍅 and Potato 🥔** images.

The application uses a **MobileNetV2 image classification model** trained with **TensorFlow/Keras** and converted to **TensorFlow Lite (TFLite)** for efficient on-device inference.

The trained AI model is integrated directly into the Flutter application, allowing CropLit to perform disease detection **offline without requiring a continuous internet connection**.

## 🚀 Key Features

* 📷 Capture Tomato or Potato images using the camera
* 🖼️ Select images from the device gallery
* 🤖 AI-powered crop disease classification
* 📊 Display AI prediction and confidence level
* 🌱 Identify whether the crop is healthy or affected
* 🩺 Display disease symptoms
* 🔍 Explain possible causes
* 💊 Provide recommended treatment
* 🛡️ Provide prevention methods
* 🌐 Online and offline functionality
* ⚡ On-device AI inference using TensorFlow Lite
* 📱 Built with Flutter for mobile platforms

## 🧠 Machine Learning Model

For disease classification, CropLit uses **MobileNetV2**, a lightweight and efficient convolutional neural network architecture suitable for mobile and edge devices.

### Model Details

| Component      | Technology                    |
| -------------- | ----------------------------- |
| Architecture   | MobileNetV2                   |
| Framework      | TensorFlow / Keras            |
| Task           | Image Classification          |
| Dataset        | ~1,800 Tomato & Potato Images |
| Training Model | `crop_disease_model.keras`    |
| Mobile Model   | `crop_disease_model.tflite`   |
| Deployment     | Flutter Mobile Application    |
| Inference      | On-device / Offline           |

## 🔄 AI Pipeline

```text
Tomato / Potato Image
        ↓
Camera or Gallery
        ↓
Image Preprocessing
        ↓
MobileNetV2
        ↓
Disease Classification
        ↓
AI Confidence Score
        ↓
Disease Information
        ↓
Symptoms | Causes | Treatment | Prevention
```

## 📱 How CropLit Works

1. The user captures an image using the camera or selects one from the gallery.
2. CropLit preprocesses the image according to the model's input requirements.
3. The **TensorFlow Lite MobileNetV2 model** analyzes the image directly on the device.
4. The application generates the predicted crop/disease class and confidence score.
5. CropLit displays relevant information such as:

   * Disease name
   * Confidence level
   * Symptoms
   * Causes
   * Recommended treatment
   * Prevention methods

## 🛠️ Technologies Used

**Mobile Development**

* Flutter
* Dart

**Artificial Intelligence**

* TensorFlow
* Keras
* MobileNetV2
* TensorFlow Lite
* Image Classification

**Computer Vision**

* Image preprocessing
* Mobile image inference

## 📂 Model Files

```text
crop_disease_model.keras
        ↓
TensorFlow Lite Conversion
        ↓
crop_disease_model.tflite
        ↓
Flutter Integration
        ↓
On-Device Disease Detection
```

## 🎯 Project Objective

The main objective of CropLit is to demonstrate how **Artificial Intelligence and mobile application development can be combined to create practical agriculture-focused solutions**.

By deploying the trained model with TensorFlow Lite, CropLit can perform predictions directly on a mobile device, making the application useful even in situations where internet connectivity is unavailable.

## 🔮 Future Improvements

Possible future improvements include:

* Supporting additional crops
* Expanding the disease dataset
* Improving model accuracy
* Adding multilingual support
* Adding more detailed agricultural recommendations
* Cloud-based model updates
* Farmer-focused agricultural resources

## 👨‍💻 Project

**CropLit — AI-Powered Crop Disease Detection**

Built with ❤️ using **Flutter, TensorFlow, MobileNetV2, and TensorFlow Lite**.

#Flutter #TensorFlow #MobileNetV2 #TensorFlowLite #AI #MachineLearning #AgriTech

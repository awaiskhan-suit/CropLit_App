class DiseaseInfo {
  final String name;
  final String crop;
  final String symptoms;
  final String cause;
  final String treatment;
  final String prevention;
  final bool healthy;

  const DiseaseInfo({
    required this.name,
    required this.crop,
    required this.symptoms,
    required this.cause,
    required this.treatment,
    required this.prevention,
    this.healthy = false,
  });
}

final Map<String, DiseaseInfo> diseaseDatabase = {

  // ============================================================
  // POTATO DISEASES
  // ============================================================

  "Potato___Black Scurf": const DiseaseInfo(
    name: "Black Scurf",
    crop: "Potato",
    symptoms:
    "Dark black patches or crust-like structures appear on potato tubers.",
    cause:
    "Usually associated with the fungus Rhizoctonia solani.",
    treatment:
    "Use certified seed potatoes. Common fungicide active ingredients used for management include azoxystrobin or flutolanil. Follow the product label and local agricultural recommendations.",
    prevention:
    "Use certified disease-free seed, maintain good soil drainage, avoid excessive irrigation, and practice crop rotation.",
  ),

  "Potato___Blackleg": const DiseaseInfo(
    name: "Blackleg",
    crop: "Potato",
    symptoms:
    "Black discoloration of stems, wilting leaves, and rotting around the plant base.",
    cause:
    "Bacterial infection commonly associated with Pectobacterium and Dickeya species.",
    treatment:
    "Remove severely infected plants and use disease-free certified seed. Copper-based bactericides may be used in some production systems according to local recommendations.",
    prevention:
    "Use certified seed, avoid excessive irrigation, sanitize equipment, and maintain good field hygiene.",
  ),

  "Potato___Common Scab": const DiseaseInfo(
    name: "Common Scab",
    crop: "Potato",
    symptoms:
    "Rough, corky, brown or tan lesions appear on the potato skin.",
    cause:
    "Commonly associated with Streptomyces bacteria in soil.",
    treatment:
    "Maintain suitable soil moisture. In some production systems, products containing flutolanil or other locally registered treatments may be considered, but chemical control is generally limited.",
    prevention:
    "Maintain adequate soil moisture during tuber formation, avoid excessive soil alkalinity, and practice crop rotation.",
  ),

  "Potato___Dry Rot": const DiseaseInfo(
    name: "Dry Rot",
    crop: "Potato",
    symptoms:
    "Sunken dry lesions, shriveling, and dry internal rot develop in tubers.",
    cause:
    "Often caused by Fusarium fungal species.",
    treatment:
    "Remove infected tubers. Seed treatments containing fludioxonil or other locally registered fungicides may be used according to the label.",
    prevention:
    "Handle potatoes carefully to avoid wounds and maintain suitable storage temperature and humidity.",
  ),

  "Potato___Healthy Potatoes": const DiseaseInfo(
    name: "Healthy Potato",
    crop: "Potato",
    symptoms:
    "No major visible disease symptoms detected.",
    cause:
    "The crop appears healthy based on the analyzed image.",
    treatment:
    "No disease medicine is recommended based on this prediction. Continue normal crop management and monitoring.",
    prevention:
    "Maintain proper irrigation, balanced nutrition, field hygiene, and regular crop inspection.",
    healthy: true,
  ),

  "Potato___Miscellaneous": const DiseaseInfo(
    name: "Miscellaneous Potato Condition",
    crop: "Potato",
    symptoms:
    "The image may contain a potato condition that does not clearly match the primary disease categories.",
    cause:
    "May be related to environmental stress, physical damage, pests, nutritional problems, or other factors.",
    treatment:
    "No specific medicine should be selected without identifying the exact cause. Inspect the plant or tuber and consult an agricultural specialist.",
    prevention:
    "Maintain field hygiene, balanced fertilization, proper irrigation, and regular crop monitoring.",
  ),

  "Potato___Pink Rot": const DiseaseInfo(
    name: "Pink Rot",
    crop: "Potato",
    symptoms:
    "Water-soaked areas may develop pink or salmon coloration, especially in cut tubers.",
    cause:
    "Usually caused by the soil-borne pathogen Phytophthora erythroseptica.",
    treatment:
    "Improve drainage and remove affected tubers. Products containing mefenoxam may be used in some production systems where legally registered and recommended.",
    prevention:
    "Avoid waterlogged soil, improve drainage, and practice appropriate crop rotation.",
  ),

  "Potato___Late Blight": const DiseaseInfo(
    name: "Late Blight",
    crop: "Potato",
    symptoms:
    "Dark irregular lesions appear on leaves and stems. Tubers may develop brown or reddish-brown lesions.",
    cause:
    "Caused by Phytophthora infestans.",
    treatment:
    "Common fungicide active ingredients include chlorothalonil, mancozeb, metalaxyl/mefenoxam combinations, or copper-based products depending on local registration and resistance management.",
    prevention:
    "Use resistant varieties where available, improve airflow, avoid prolonged leaf wetness, and remove infected plant material.",
  ),

  "Potato___Early Blight": const DiseaseInfo(
    name: "Early Blight",
    crop: "Potato",
    symptoms:
    "Brown circular lesions with concentric rings develop on older leaves.",
    cause:
    "Usually caused by Alternaria solani.",
    treatment:
    "Commonly used fungicide active ingredients include chlorothalonil, mancozeb, azoxystrobin, or difenoconazole where locally registered.",
    prevention:
    "Use crop rotation, maintain balanced nutrition, remove plant debris, and avoid prolonged leaf wetness.",
  ),

  "Potato___Soft Rot": const DiseaseInfo(
    name: "Soft Rot",
    crop: "Potato",
    symptoms:
    "Tubers become soft, watery, discolored, and may develop an unpleasant odor.",
    cause:
    "Usually caused by soft-rot bacteria such as Pectobacterium species.",
    treatment:
    "Remove infected tubers and improve storage conditions. There is no reliable curative medicine for already rotted tubers.",
    prevention:
    "Avoid mechanical damage, maintain proper storage ventilation, and prevent excessive moisture.",
  ),

  // ============================================================
  // TOMATO DISEASES
  // ============================================================

  "Tomato___Anthracnose": const DiseaseInfo(
    name: "Anthracnose",
    crop: "Tomato",
    symptoms:
    "Small dark, sunken spots develop and may enlarge on ripening tomato fruit.",
    cause:
    "Fungal infection caused by Colletotrichum species.",
    treatment:
    "Fungicides containing azoxystrobin, chlorothalonil, or copper-based active ingredients may be used where registered and appropriate.",
    prevention:
    "Remove infected fruit, avoid overhead irrigation, improve airflow, and remove infected plant debris.",
  ),

  "Tomato___Blossom_End_Rot": const DiseaseInfo(
    name: "Blossom End Rot",
    crop: "Tomato",
    symptoms:
    "A dark, sunken, leathery area develops at the blossom end of the fruit.",
    cause:
    "Usually associated with inconsistent water availability and calcium transport problems.",
    treatment:
    "This is not primarily a fungal disease, so fungicide is not the solution. Maintain consistent irrigation and appropriate calcium nutrition.",
    prevention:
    "Avoid irregular watering, maintain soil moisture, and maintain balanced plant nutrition.",
  ),

  "Tomato___Catfaced": const DiseaseInfo(
    name: "Catfaced",
    crop: "Tomato",
    symptoms:
    "Irregular, distorted fruit with deep scars or cavities around the blossom end.",
    cause:
    "Often associated with environmental stress during flowering and fruit development.",
    treatment:
    "No specific medicine is normally required. Improve growing conditions and reduce environmental stress.",
    prevention:
    "Avoid temperature extremes, maintain stable irrigation, and provide proper plant nutrition.",
  ),

  "Tomato___Fruit_Cracking": const DiseaseInfo(
    name: "Fruit Cracking",
    crop: "Tomato",
    symptoms:
    "Cracks or splits develop around the fruit, commonly after rapid water uptake.",
    cause:
    "Rapid changes in water availability and fruit growth.",
    treatment:
    "No specific fungicide is required for cracking itself. Maintain consistent irrigation and remove severely damaged fruit.",
    prevention:
    "Avoid irregular watering and maintain consistent soil moisture.",
  ),

  "Tomato___Healthy_Tomato": const DiseaseInfo(
    name: "Healthy Tomato",
    crop: "Tomato",
    symptoms:
    "No major visible disease symptoms detected.",
    cause:
    "The crop appears healthy based on the analyzed image.",
    treatment:
    "No disease medicine is recommended based on this prediction. Continue normal crop care and monitoring.",
    prevention:
    "Continue regular monitoring, proper irrigation, balanced nutrition, and field hygiene.",
    healthy: true,
  ),

  "Tomato___Late_Blight": const DiseaseInfo(
    name: "Late Blight",
    crop: "Tomato",
    symptoms:
    "Dark irregular lesions develop on leaves and stems. Fruit may develop brown lesions.",
    cause:
    "Caused by Phytophthora infestans.",
    treatment:
    "Commonly used fungicide active ingredients include chlorothalonil, mancozeb, copper compounds, or mefenoxam combinations where locally registered.",
    prevention:
    "Improve airflow, avoid prolonged leaf wetness, remove infected plant material, and monitor crops frequently.",
  ),

  "Tomato___Mold": const DiseaseInfo(
    name: "Mold",
    crop: "Tomato",
    symptoms:
    "Mold-like growth, discoloration, or decay may appear on affected plant or fruit tissue.",
    cause:
    "Often associated with fungal growth under humid and poorly ventilated conditions.",
    treatment:
    "Remove affected material and improve ventilation. Copper-based fungicides or other locally registered fungicides may be considered depending on the identified fungus.",
    prevention:
    "Reduce excessive humidity, improve airflow, and avoid prolonged leaf wetness.",
  ),

  "Tomato___Spotted_Wilt_Virus": const DiseaseInfo(
    name: "Spotted Wilt Virus",
    crop: "Tomato",
    symptoms:
    "Spots, discoloration, leaf distortion, and possible stunted plant growth.",
    cause:
    "Viral disease commonly transmitted by thrips.",
    treatment:
    "There is no curative medicine for the virus itself. Remove severely infected plants and manage thrips using locally recommended insect-control measures.",
    prevention:
    "Control thrips, remove infected plant material, control weeds, and use resistant varieties where available.",
  ),

  "Tomato___Early_Blight": const DiseaseInfo(
    name: "Early Blight",
    crop: "Tomato",
    symptoms:
    "Dark brown circular lesions with concentric rings appear on older leaves and may spread upward.",
    cause:
    "Usually caused by Alternaria solani.",
    treatment:
    "Fungicide active ingredients such as chlorothalonil, mancozeb, azoxystrobin, or difenoconazole may be used where locally registered.",
    prevention:
    "Use crop rotation, remove infected leaves, improve airflow, and avoid overhead irrigation.",
  ),

  "Tomato___Powdery_Mildew": const DiseaseInfo(
    name: "Powdery Mildew",
    crop: "Tomato",
    symptoms:
    "White powder-like fungal growth appears on leaves and stems.",
    cause:
    "Caused by powdery mildew fungi.",
    treatment:
    "Products containing sulfur, potassium bicarbonate, or certain fungicide active ingredients may be used according to local registration and label directions.",
    prevention:
    "Improve airflow, avoid excessive humidity, and monitor plants regularly.",
  ),

  "Tomato___Bacterial_Spot": const DiseaseInfo(
    name: "Bacterial Spot",
    crop: "Tomato",
    symptoms:
    "Small dark spots develop on leaves, stems, and fruit. Severe infections may cause leaf drop.",
    cause:
    "Caused by Xanthomonas bacterial species.",
    treatment:
    "Copper-based bactericides may provide protection. Some products combine copper with other active ingredients; use only locally registered products according to their labels.",
    prevention:
    "Use clean seed and transplants, avoid working with wet plants, and remove infected plant debris.",
  ),

  "Tomato___Mosaic_Virus": const DiseaseInfo(
    name: "Tomato Mosaic Virus",
    crop: "Tomato",
    symptoms:
    "Mottled light and dark green leaves, leaf distortion, and reduced plant growth may occur.",
    cause:
    "Viral infection caused by tomato mosaic virus and related viruses.",
    treatment:
    "There is no curative medicine for the virus. Remove infected plants and control possible sources of transmission.",
    prevention:
    "Use clean tools and planting material, wash hands after handling plants, and remove infected plants.",
  ),
};
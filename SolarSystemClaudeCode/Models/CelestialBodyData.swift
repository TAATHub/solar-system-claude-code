//
//  CelestialBodyData.swift
//  SolarSystemClaudeCode
//
//  Created by TAAT on 2025/10/08.
//

import Foundation

/// 太陽系の天体データ定義
struct CelestialBodyData {
    /// 太陽のモデルデータ
    static let sun = CelestialBodyModel(
        modelName: "Sun",
        size: 1.0,                // 太陽の視認サイズ
        tiltAngleDegrees: 7.25,   // 太陽の自転軸傾き
        rotationPeriod: 2.0,      // 視認性のため圧縮
        orbitRadius: 0.0,         // 太陽は公転しない
        orbitPeriod: 0.0,         // 太陽は公転しない
        description: "太陽系の中心にある恒星です。質量は地球の33万倍で、主に水素とヘリウムからなり、核融合反応により膨大なエネルギーを生成しています。表面温度は約6000度、中心部は約1500万度に達し、全ての惑星に光と熱を供給し続けています。太陽の寿命はあと約50億年と考えられています。"
    )

    /// 地球のモデルデータ
    static let earth = CelestialBodyModel(
        modelName: "Earth",
        size: 0.3,                // 視認性を重視したサイズ
        tiltAngleDegrees: 23.44,  // 地軸の傾き
        rotationPeriod: 1.0,      // 1日で自転（視認性のため実時間スケール）
        orbitRadius: 5.0,         // 視認性のため圧縮
        orbitPeriod: 10.0,        // 視認性のため圧縮
        description: "太陽から3番目の惑星で、太陽系で唯一生命が確認されている惑星です。表面の約70%が水で覆われ、窒素と酸素からなる大気に包まれています。地軸が23.4度傾いているため四季が生まれます。直径は約12,742km、1年は365.25日です。月という衛星を持ち、潮の満ち引きなど地球環境に大きな影響を与えています。"
    )

    /// 月のモデルデータ
    static let moon = CelestialBodyModel(
        modelName: "Moon",
        size: 0.08,               // 視認性を重視したサイズ(Earthの約1/4)
        tiltAngleDegrees: 1.54,   // 月の自転軸傾き
        rotationPeriod: 2.0,      // 潮汐ロック（公転周期と同じ）
        orbitRadius: 0.5,         // 地球からの距離（視認性重視で圧縮）
        orbitPeriod: 2.0,         // 約27日（視認性のため圧縮）
        description: "地球の唯一の天然衛星で、直径は約3,474km、地球の約1/4のサイズです。地球からの平均距離は約38万kmで、公転周期と自転周期が同じ27.3日のため、常に同じ面を地球に向けています。表面はクレーターで覆われ、大気はほとんどありません。地球の潮汐や地軸の安定に重要な役割を果たしています。"
    )

    /// 水星のモデルデータ
    static let mercury = CelestialBodyModel(
        modelName: "Mercury",
        size: 0.15,               // 視認性を重視したサイズ
        tiltAngleDegrees: 0.034,  // 水星の自転軸傾き
        rotationPeriod: 5.0,      // 視認性のため圧縮
        orbitRadius: 3.0,         // 視認性のため圧縮
        orbitPeriod: 7.0,         // 約88日（視認性のため圧縮）
        description: "太陽に最も近い惑星で、直径は約4,879kmと太陽系で最も小さい惑星です。大気がほとんどないため昼夜の温度差が激しく、昼は430度、夜はマイナス180度にもなります。表面は月のようにクレーターだらけで、公転周期は約88日です。自転が非常に遅く、1日は地球時間で約59日に相当します。"
    )

    /// 金星のモデルデータ
    static let venus = CelestialBodyModel(
        modelName: "Venus",
        size: 0.28,               // 視認性を重視したサイズ
        tiltAngleDegrees: 177.4,  // 金星の自転軸傾き（逆回転）
        rotationPeriod: 20.0,     // 非常に遅い自転（視認性のため圧縮）
        orbitRadius: 4.0,         // 視認性のため圧縮
        orbitPeriod: 8.5,         // 約225日（視認性のため圧縮）
        description: "地球に最も近い惑星で、大きさも地球とほぼ同じ直径約12,104kmです。二酸化炭素の厚い大気により温室効果が極端で、表面温度は約470度と太陽系で最も高温です。硫酸の雲に覆われ、気圧は地球の90倍にもなります。自転が逆向きで非常に遅く、1日は地球時間で約243日、1年より長いのが特徴です。"
    )

    /// 火星のモデルデータ
    static let mars = CelestialBodyModel(
        modelName: "Mars",
        size: 0.2,                // 視認性を重視したサイズ
        tiltAngleDegrees: 25.19,  // 火星の自転軸傾き
        rotationPeriod: 1.1,      // 地球とほぼ同じ自転速度
        orbitRadius: 6.5,         // 視認性のため圧縮
        orbitPeriod: 12.0,        // 約687日（視認性のため圧縮）
        description: "赤い惑星として知られ、直径は約6,779kmで地球の約半分です。表面の酸化鉄により赤く見えます。大気は薄く、主に二酸化炭素で構成され、平均気温はマイナス60度です。かつて水が流れていた証拠が多数発見されており、生命の痕跡を探す探査が続けられています。フォボスとダイモスという2つの小さな衛星を持っています。"
    )

    /// 木星のモデルデータ
    static let jupiter = CelestialBodyModel(
        modelName: "Jupiter",
        size: 0.6,                // 視認性を重視したサイズ（巨大惑星）
        tiltAngleDegrees: 0,      // 木星の自転軸傾き
        rotationPeriod: 0.4,      // 非常に速い自転
        orbitRadius: 10.0,        // 視認性のため圧縮
        orbitPeriod: 20.0,        // 約11.9年（視認性のため圧縮）
        description: "太陽系最大の惑星で、直径は約139,820kmと地球の約11倍です。主に水素とヘリウムからなるガス惑星で、表面に見える縞模様は激しい大気の流れです。大赤斑と呼ばれる巨大な渦は地球が2〜3個入る大きさで、300年以上も存在しています。80個以上の衛星を持ち、強力な磁場により放射線帯を形成しています。"
    )

    /// 土星のモデルデータ
    static let saturn = CelestialBodyModel(
        modelName: "Saturn",
        size: 0.55,               // 視認性を重視したサイズ（巨大惑星）
        tiltAngleDegrees: 26.73,  // 土星の自転軸傾き
        rotationPeriod: 0.45,     // 速い自転
        orbitRadius: 13.0,        // 視認性のため圧縮
        orbitPeriod: 25.0,        // 約29.5年（視認性のため圧縮）
        description: "美しい環を持つことで有名な惑星で、直径は約116,460kmと木星に次ぐ大きさです。環は主に氷の粒子で構成され、幅は28万kmにも及びますが厚さは数十メートルしかありません。木星と同様にガス惑星で、密度が非常に低く水に浮くほどです。80個以上の衛星を持ち、タイタンは大気を持つ唯一の衛星として知られています。"
    )

    /// 天王星のモデルデータ
    static let uranus = CelestialBodyModel(
        modelName: "Uranus",
        size: 0.4,                // 視認性を重視したサイズ
        tiltAngleDegrees: 97.77,  // 天王星の自転軸傾き（横倒し）
        rotationPeriod: 0.7,      // 逆回転
        orbitRadius: 16.0,        // 視認性のため圧縮
        orbitPeriod: 35.0,        // 約84年（視認性のため圧縮）
        description: "直径約50,724kmの氷惑星で、自転軸が約98度傾いているため横倒しに自転する珍しい惑星です。メタンガスを含む大気により淡い青緑色に見えます。内部は水、メタン、アンモニアの氷で構成され、表面温度はマイナス220度以下です。27個の衛星と13本の淡い環を持ち、公転周期は約84年と長く、極地方では42年間も昼または夜が続きます。"
    )

    /// 海王星のモデルデータ
    static let neptune = CelestialBodyModel(
        modelName: "Neptune",
        size: 0.38,               // 視認性を重視したサイズ
        tiltAngleDegrees: 28.32,  // 海王星の自転軸傾き
        rotationPeriod: 0.65,     // 速い自転
        orbitRadius: 19.0,        // 視認性のため圧縮
        orbitPeriod: 40.0,        // 約165年（視認性のため圧縮）
        description: "太陽から最も遠い惑星で、直径は約49,244kmです。天王星と同様に氷惑星で、メタンにより深い青色をしています。太陽系で最も強い風が吹き、時速2000kmにも達します。表面温度はマイナス220度以下と極寒です。14個の衛星を持ち、最大のトリトンは逆行軌道という珍しい特徴があります。公転周期は約165年で、発見以来まだ1周もしていません。"
    )
}

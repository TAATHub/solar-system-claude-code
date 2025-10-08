//
//  CelestialBodyData.swift
//  SolarSystemClaudeCode
//
//  Created by TAAT on 2025/10/08.
//

import Foundation

/// 太陽系の天体データ定義
struct CelestialBodyData {
    /// 地球のモデルデータ
    static let earth = CelestialBodyModel(
        modelName: "Earth",
        size: 0.3,                // 視認性を重視したサイズ
        tiltAngleDegrees: 23.44,  // 地軸の傾き
        rotationPeriod: 1.0,      // 1日で自転（視認性のため実時間スケール）
        orbitRadius: 5.0,         // 視認性のため圧縮
        orbitPeriod: 10.0         // 視認性のため圧縮
    )

    /// 月のモデルデータ
    static let moon = CelestialBodyModel(
        modelName: "Moon",
        size: 0.08,               // 視認性を重視したサイズ(Earthの約1/4)
        tiltAngleDegrees: 1.54,   // 月の自転軸傾き
        rotationPeriod: 2.0,      // 潮汐ロック（公転周期と同じ）
        orbitRadius: 0.5,         // 地球からの距離（視認性重視で圧縮）
        orbitPeriod: 2.0          // 約27日（視認性のため圧縮）
    )

    /// 水星のモデルデータ
    static let mercury = CelestialBodyModel(
        modelName: "Mercury",
        size: 0.15,               // 視認性を重視したサイズ
        tiltAngleDegrees: 0.034,  // 水星の自転軸傾き
        rotationPeriod: 5.0,      // 視認性のため圧縮
        orbitRadius: 3.0,         // 視認性のため圧縮
        orbitPeriod: 7.0          // 約88日（視認性のため圧縮）
    )

    /// 金星のモデルデータ
    static let venus = CelestialBodyModel(
        modelName: "Venus",
        size: 0.28,               // 視認性を重視したサイズ
        tiltAngleDegrees: 177.4,  // 金星の自転軸傾き（逆回転）
        rotationPeriod: 20.0,     // 非常に遅い自転（視認性のため圧縮）
        orbitRadius: 4.0,         // 視認性のため圧縮
        orbitPeriod: 8.5          // 約225日（視認性のため圧縮）
    )

    /// 火星のモデルデータ
    static let mars = CelestialBodyModel(
        modelName: "Mars",
        size: 0.2,                // 視認性を重視したサイズ
        tiltAngleDegrees: 25.19,  // 火星の自転軸傾き
        rotationPeriod: 1.1,      // 地球とほぼ同じ自転速度
        orbitRadius: 6.5,         // 視認性のため圧縮
        orbitPeriod: 12.0         // 約687日（視認性のため圧縮）
    )

    /// 木星のモデルデータ
    static let jupiter = CelestialBodyModel(
        modelName: "Jupiter",
        size: 0.6,                // 視認性を重視したサイズ（巨大惑星）
        tiltAngleDegrees: 0,      // 木星の自転軸傾き
        rotationPeriod: 0.4,      // 非常に速い自転
        orbitRadius: 10.0,        // 視認性のため圧縮
        orbitPeriod: 20.0         // 約11.9年（視認性のため圧縮）
    )

    /// 土星のモデルデータ
    static let saturn = CelestialBodyModel(
        modelName: "Saturn",
        size: 0.55,               // 視認性を重視したサイズ（巨大惑星）
        tiltAngleDegrees: 26.73,  // 土星の自転軸傾き
        rotationPeriod: 0.45,     // 速い自転
        orbitRadius: 13.0,        // 視認性のため圧縮
        orbitPeriod: 25.0         // 約29.5年（視認性のため圧縮）
    )

    /// 天王星のモデルデータ
    static let uranus = CelestialBodyModel(
        modelName: "Uranus",
        size: 0.4,                // 視認性を重視したサイズ
        tiltAngleDegrees: 97.77,  // 天王星の自転軸傾き（横倒し）
        rotationPeriod: 0.7,      // 逆回転
        orbitRadius: 16.0,        // 視認性のため圧縮
        orbitPeriod: 35.0         // 約84年（視認性のため圧縮）
    )

    /// 海王星のモデルデータ
    static let neptune = CelestialBodyModel(
        modelName: "Neptune",
        size: 0.38,               // 視認性を重視したサイズ
        tiltAngleDegrees: 28.32,  // 海王星の自転軸傾き
        rotationPeriod: 0.65,     // 速い自転
        orbitRadius: 19.0,        // 視認性のため圧縮
        orbitPeriod: 40.0         // 約165年（視認性のため圧縮）
    )
}

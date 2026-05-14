import 'dart:math';
import 'dart:typed_data';

import 'package:pointycastle/export.dart';

class ECCService {
  static AsymmetricKeyPair<
      PublicKey,
      PrivateKey> generateKeyPair() {
    final keyGen = ECKeyGenerator();

    final secureRandom =
        FortunaRandom();

    final random = Random.secure();

    final seeds =
        List<int>.generate(
      32,
      (_) => random.nextInt(256),
    );

    secureRandom.seed(
      KeyParameter(
        Uint8List.fromList(seeds),
      ),
    );

    final ecParams =
        ECDomainParameters(
      'prime256v1',
    );

    final params =
        ParametersWithRandom(
      ECKeyGeneratorParameters(
        ecParams,
      ),
      secureRandom,
    );

    keyGen.init(params);

    return keyGen.generateKeyPair();
  }
}
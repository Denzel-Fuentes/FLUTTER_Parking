import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parking_app/models/Proposal.dart';
import 'package:parking_app/services/repository.dart';

class ProposalRepository extends Repository<Proposal> {
  ProposalRepository()
      : super(
            collection: FirebaseFirestore.instance.collection('proposals'),
            fromJson: (json) => Proposal.fromJson(json),
            toJson: (item) => item.toJson());
}

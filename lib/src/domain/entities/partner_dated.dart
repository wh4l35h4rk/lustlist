import 'package:lustlist/src/domain/repository.dart';
import 'package:lustlist/src/core/utils/utils.dart';
import 'package:lustlist/src/database/database.dart';

class PartnerWithDate {
  final Partner partner;
  final DateTime? lastDate;

  PartnerWithDate(this.partner, this.lastDate);
}

extension EventRepositoryPartnerDates on EventRepository {

  Future<PartnerWithDate> getPartnerWithDate(Partner p) async {
    DateTime date = await getPartnerLastEventDate(p.id);
    return PartnerWithDate(p, date);
  }

  Future<List<PartnerWithDate>> getPartnersWithDatesSorted(bool withUnknown) async {
    List<Partner> partners = await db.allPartners;
    final unknownPartner = await getUnknownPartner();

    List<PartnerWithDate> partnersWithDates = [];
    for (Partner p in partners){
      if (!withUnknown && p == unknownPartner) continue;
      var pwd = await getPartnerWithDate(p);
      partnersWithDates.add(pwd);
    }

    partnersWithDates.sort((a, b) {
      final aDate = a.lastDate ?? defaultDate;
      final bDate = b.lastDate ?? defaultDate;
      return -1 * aDate.compareTo(bDate);
    });

    return partnersWithDates;
  }
}

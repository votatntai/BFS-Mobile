import 'package:flutter_application_1/domain/repositories/ticket_repo.dart';
import 'package:flutter_application_1/utils/get_it.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'ticket_state.dart';

class TicketCubit extends Cubit<TicketState>{
  TicketCubit() : super(TicketState());
  final TicketRepo ticketRepo = getIt.get<TicketRepo>();

  Future<void> getTickets({String? cageId, String? ticketCategory, int? pageNumber, int? pageSize}) async {
    emit(GetTicketLoadingState());
    try {
      final tickets = await ticketRepo.getTickets(cageId: cageId, ticketCategory: ticketCategory, pageNumber: pageNumber, pageSize: pageSize);
      emit(GetTicketSuccessState(tickets));
    } catch (e) {
      emit(GetTicketFailedState(e.toString()));
    }
  }

  
}
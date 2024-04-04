import 'package:flutter_application_1/domain/repositories/ticket_repo.dart';
import 'package:flutter_application_1/utils/get_it.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

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

  Future<void> addTicket({required String title, String? ticketCategory, String? creatorId, String? priority, required String description, String? assigneeId, String? cageId, required XFile image}) async {
    emit(CreateTicketLoadingState());
    try {
      await ticketRepo.addTicket(title: title, ticketCategory: ticketCategory, creatorId: creatorId, priority: priority, description: description, assigneeId: assigneeId, cageId: cageId, image: image);
      emit(CreateTicketSuccessState());
    } catch (e) {
      emit(CreateTicketFailedState(e.toString()));
    }
  }
}
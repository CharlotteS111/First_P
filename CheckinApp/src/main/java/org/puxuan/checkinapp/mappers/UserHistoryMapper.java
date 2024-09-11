package org.puxuan.checkinapp.mappers;

import org.mapstruct.*;
import org.puxuan.checkinapp.dtos.UserHistoryDto;
import org.puxuan.checkinapp.entities.UserHistory;

@Mapper(unmappedTargetPolicy = ReportingPolicy.IGNORE, componentModel = MappingConstants.ComponentModel.SPRING)public interface UserHistoryMapper {
    UserHistory toEntity(UserHistoryDto userHistoryDto);

    UserHistoryDto toDto(UserHistory userHistory);

    @BeanMapping(nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)UserHistory partialUpdate(UserHistoryDto userHistoryDto, @MappingTarget UserHistory userHistory);
}

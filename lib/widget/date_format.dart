// ignore_for_file: constant_identifier_names

class DateFormatte {
  final List<String> formats;

  const DateFormatte(this.formats);

  String format(DateTime date) {
    var sb = StringBuffer();

    for (var format in formats) {
      if (format == mm) {
        sb.write(_pad0(date.minute, 2));
      } else if (format == m) {
        sb.write(date.minute);
      } else if (format == HH) {
        sb.write(_pad0(date.hour, 2));
      } else if (format == H) {
        sb.write(date.hour);
      } else if (format == dddd) {
        sb.write(daysLong[date.weekday - 1]);
      } else if (format == ddd) {
        sb.write(daysShort[date.weekday - 1]);
      } else if (format == dd) {
        sb.write(_pad0(date.day, 2));
      } else if (format == d) {
        sb.write(date.day);
      } else if (format == MMMM) {
        sb.write(monthsLong[date.month - 1]);
      } else if (format == MMM) {
        sb.write(monthsShort[date.month - 1]);
      } else if (format == MM) {
        sb.write(_pad0(date.month, 2));
      } else if (format == M) {
        sb.write(date.month);
      } else if (format == y) {
        sb.write(date.year);
      } else {
        sb.write(format);
      }
    }

    return sb.toString();
  }

  String _pad0(int value, int length) {
    return '$value'.padLeft(length, '0');
  }
}

const y = 'yyyy';
const M = 'M';
const MM = 'MM';
const MMM = 'MMM';
const MMMM = 'MMMM';
const d = 'd';
const dd = 'dd';
const ddd = 'ddd';
const dddd = 'dddd';
const H = 'H';
const HH = 'HH';
const m = 'm';
const mm = 'mm';

const monthsShort = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec'
];

const monthsLong = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December'
];

const daysShort = [
  'Mon',
  'Tue',
  'Wed',
  'Thu',
  'Fri',
  'Sat',
  'Sun',
];

const daysLong = [
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Saturday',
  'Sunday'
];

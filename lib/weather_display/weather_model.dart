import 'package:final_project/weather_display/xmlUtils.dart';
import 'package:xml/xml.dart';

class Weather_Model {
  String? tm;
  String? thema;
  String? courseId;
  String? courseAreaId;
  String? courseAreaName;
  String? courseName;
  String? spotAreaId;
  String? spotAreaName;
  String? spotName;
  String? th3;
  String? wd;
  String? ws;
  String? sky;
  String? rhm;
  String? pop;

  Weather_Model({
    this.tm,
    this.thema,
    this.courseId,
    this.courseAreaId,
    this.courseAreaName,
    this.courseName,
    this.spotAreaId,
    this.spotAreaName,
    this.spotName,
    this.th3,
    this.wd,
    this.ws,
    this.sky,
    this.rhm,
    this.pop,
  });
  factory Weather_Model.fromXml(XmlElement xml) {
    return Weather_Model(
      tm: XmlUtils.searchResult(xml, 'tm'),
      thema: XmlUtils.searchResult(xml, 'thema'),
      courseId: XmlUtils.searchResult(xml, 'courseId'),
      courseAreaId: XmlUtils.searchResult(xml, 'courseAreaId'),
      courseAreaName: XmlUtils.searchResult(xml, 'courseAreaName'),
      courseName: XmlUtils.searchResult(xml, 'courseName'),
      spotAreaId: XmlUtils.searchResult(xml, 'spotAreaId'),
      spotAreaName: XmlUtils.searchResult(xml, 'spotAreaName'),
      spotName: XmlUtils.searchResult(xml, 'spotName'),
      th3: XmlUtils.searchResult(xml, 'th3'),
      wd: XmlUtils.searchResult(xml, 'wd'),
      ws: XmlUtils.searchResult(xml, 'ws'),
      sky: XmlUtils.searchResult(xml, 'sky'),
      rhm: XmlUtils.searchResult(xml, 'rhm'),
      pop: XmlUtils.searchResult(xml, 'pop'),
    );
  }
}

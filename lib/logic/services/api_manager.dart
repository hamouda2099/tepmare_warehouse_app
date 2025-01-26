import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tepmare_warehouse_man_app/logic/services/cache_manager.dart';

import '../../config/env.dart';
import '../../models/categories_model.dart';
import '../../models/client_model.dart';
import '../../models/clients_model.dart';
import '../../models/items_model.dart';
import '../../models/locations_model.dart';
import '../../models/login_model.dart';
import '../../models/shipment_details_model.dart';
import '../../models/shipments_model.dart';
import '../../models/sites_model.dart';
import '../../models/statistics_model.dart';
import '../../models/stock_model.dart';



class ApiManager {
  static final String _login = '${Env.baseApi}/login';
  static final String _statisticsUrl = '${Env.baseApi}/statistics';
  static final String _adminsUrl = '${Env.baseApi}/admins';
  static final String _usersUrl = '${Env.baseApi}/users';
  static final String _userUrl = '${Env.baseApi}/user';
  static final String _createUserUrl = '${Env.baseApi}/create_user';
  static final String _clientsUrl = '${Env.baseApi}/clients';
  static final String _clientUrl = '${Env.baseApi}/client';
  static final String _createClientUrl = '${Env.baseApi}/create_client';
  static final String _stockUrl = '${Env.baseApi}/stock';
  static final String _sitesUrl = '${Env.baseApi}/sites';
  static final String _siteUrl = '${Env.baseApi}/site';
  static final String _createSiteUrl = '${Env.baseApi}/create_site';
  static final String _categoriesUrl = '${Env.baseApi}/categories';
  static final String _createCategoryUrl = '${Env.baseApi}/create_category';
  static final String _createLocationUrl = '${Env.baseApi}/create_location';
  static final String _locationsUrl = '${Env.baseApi}/locations';
  static final String _locationUrl = '${Env.baseApi}/location';

  static final String _itemsUrl = '${Env.baseApi}/items';
  static final String _createItemUrl = '${Env.baseApi}/create_item';
  static final String _vouchersUrl = '${Env.baseApi}/vouchers';
  static final String _vouchersGoodsUrl = '${Env.baseApi}/vouchers_goods';
  static final String _entryShipmentUrl = '${Env.baseApi}/entry_shipment';
  static final String _exitShipmentUrl = '${Env.baseApi}/exit_shipment';
  static final String _shipmentsUrl = '${Env.baseApi}/shipments';
  static final String _shipmentUrl = '${Env.baseApi}/shipment';
  static final String _receiveItemUrl = '${Env.baseApi}/receive_item';
  static final String _completeShipmentUrl = '${Env.baseApi}/complete_shipment';
  static final String _deliverShipmentUrl = '${Env.baseApi}/deliver_shipment';
  static final String _trackingOrdersUrl = '${Env.baseApi}/tracking_orders';
  static final String _uploadDocumentsUrl = '${Env.baseApi}/upload_document';
  static final String _uploadInvoiceUrl = '${Env.baseApi}/upload_invoice';
  static final String _getSupplierInvoicesUrl =
      '${Env.baseApi}/supplier_invoices';
  static final String _getDocumentsUrl = '${Env.baseApi}/order_documents';
  static final String _trackingShipmentsUrl =
      '${Env.baseApi}/tracking_shipments';

  static String toQuery(Map<String, dynamic> parameters) {
    try {
      parameters.removeWhere((key, value) =>
          key == null ||
          value == null ||
          key.toString().isEmpty ||
          value.toString().isEmpty);
    } catch (_) {}
    return '?${Uri(
      queryParameters: parameters,
    ).query}';
  }

  static Future<http.Response> sendPostRequest(
    String url,
    Map<String, dynamic> parameters,
  ) async {
    try {
      parameters.removeWhere((key, value) =>
          key == null ||
          value == null ||
          key.toString().isEmpty ||
          value.toString().isEmpty);
    } catch (_) {}

    return await http.post(
      Uri.parse(url),
      body: jsonEncode(parameters),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': CacheManager.getUserToken() ?? "-",
      },
    );
  }

  static Future<http.Response> sendGetRequest(String url) async {
    return await http.get(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': CacheManager.getUserToken() ?? "-",
      },
    );
  }

  static Future<http.Response> sendDeleteRequest(String url) async {
    return await http.delete(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': CacheManager.getUserToken() ?? "-",
      },
    );
  }

  static Future<http.Response> sendPutRequest(
    String url,
    Map<String, dynamic> parameters,
  ) async {
    try {
      parameters.removeWhere((key, value) =>
          key == null ||
          value == null ||
          key.toString().isEmpty ||
          value.toString().isEmpty);
    } catch (_) {}

    return await http.put(
      Uri.parse(url),
      body: jsonEncode(parameters),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': CacheManager.getUserToken() ?? "-",
      },
    );
  }

  static Future<LoginModel> login({
    required String username,
    required String password,
  }) async {
    Map<String, dynamic> parameters = {
      'username': username,
      'password': password,
    };

    return LoginModel.fromJson(
        jsonDecode((await sendPostRequest(_login, parameters)).body));
  }

  static Future<StatisticsModel> getStatistics({
    String? clientId = '',
  }) async {
    Map<String, String> parameters = {};
    return StatisticsModel.fromJson(json.decode(
        (await sendGetRequest("$_statisticsUrl${toQuery(parameters)}")).body));
  }



  static Future<StockModel> getStock({
    String page = '1',
    String limit = '10',
    String query = '',
    String? clientId,
  }) async {
    Map<String, dynamic> parameters = {
      "page": page,
      "limit": limit,
      "query": query,
      "clientId": clientId,
    };
    return StockModel.fromJson(json
        .decode((await sendGetRequest(_stockUrl + toQuery(parameters))).body));
  }

  static Future<SitesModel> getSites({
    String page = '1',
    String limit = '10',
    String query = '',
  }) async {
    Map<String, String> parameters = {
      "page": page,
      "limit": limit,
      "query": query
    };
    return SitesModel.fromJson(json
        .decode((await sendGetRequest(_sitesUrl + toQuery(parameters))).body));
  }
  static Future<dynamic> editSite({
    required String label,
    required String siteId,
  }) async {
    Map<String, dynamic> parameters = {"label": label};

    return jsonDecode(
        (await sendPutRequest("$_siteUrl/$siteId", parameters)).body);
  }
  static Future<dynamic> createSite({
    required String label,
  }) async {
    Map<String, dynamic> parameters = {"label": label};

    return jsonDecode((await sendPostRequest(_createSiteUrl, parameters)).body);
  }

  static Future<CategoriesModel> getCategories({
    String page = '1',
    String limit = '10',
    String query = '',
  }) async {
    Map<String, String> parameters = {
      "page": page,
      "limit": limit,
      "query": query
    };
    return CategoriesModel.fromJson(json.decode(
        (await sendGetRequest(_categoriesUrl + toQuery(parameters))).body));
  }

  static Future<dynamic> createCategory({
    required String label,
  }) async {
    Map<String, dynamic> parameters = {"label": label};

    return jsonDecode(
        (await sendPostRequest(_createCategoryUrl, parameters)).body);
  }

  static Future<dynamic> editCategory({
    required String label,
    required String categoryId,
  }) async {
    Map<String, dynamic> parameters = {"label": label};

    return jsonDecode(
        (await sendPutRequest("$_categoriesUrl/$categoryId", parameters)).body);
  }

  static Future<LocationsModel> getLocations({
    String page = '1',
    String limit = '10',
    String query = '',
  }) async {
    Map<String, String> parameters = {
      "page": page,
      "limit": limit,
      "query": query
    };
    return LocationsModel.fromJson(json.decode(
        (await sendGetRequest(_locationsUrl + toQuery(parameters))).body));
  }

  static Future<dynamic> createLocation({
    String? siteId,
    String? hall,
    String? aisle,
    String? type,
    String? position,
    String? field,
    String? level,
  }) async {
    Map<String, dynamic> parameters = {
      "hall": hall,
      "siteId": siteId,
      "aisle": aisle,
      "type": type,
      "positon": position,
      "level": level,
      "field": field,
    };

    return jsonDecode(
        (await sendPostRequest(_createLocationUrl, parameters)).body);
  }

  static Future<ClientsModel> getClients({
    String page = '1',
    String limit = '10',
    String query = '',
  }) async {
    Map<String, String> parameters = {
      "page": page,
      "limit": limit,
      "query": query
    };
    return ClientsModel.fromJson(json.decode(
        (await sendGetRequest(_clientsUrl + toQuery(parameters))).body));
  }

  static Future<ClientModel> getClientById({
    String? clientId = '',
  }) async {
    Map<String, String> parameters = {};
    return ClientModel.fromJson(json.decode(
        (await sendGetRequest("$_clientUrl/$clientId${toQuery(parameters)}"))
            .body));
  }

  static Future<dynamic> deleteLocation({
    required String id,
  }) async {
    return jsonDecode((await sendDeleteRequest('$_locationUrl/$id')).body);
  }

  static Future<dynamic> createClient({
    String? firstName,
    String? lastName,
    String? username,
    String? email,
    String? phone,
    String? password,
    String? type,
    String? companyName,
    String? fax,
    String? website,
    String? note,
    String? category,
    String? address,
    String? postalCode,
    String? villa,
    String? deliveryAddress,
    String? deliveryPostalCode,
    String? deliveryVilla,
    String? reliability,
    String? discount,
    String? delayDelivery,
    String? shippingCost,
    String? freeShippingCosts,
    String? hours,
    String? tva,
    String? siren,
    String? codeNaf,
    String? rcs,
    String? sarl,
    String? contact,
    String? iban,
    String? bic,
    String? bank,
  }) async {
    Map<String, dynamic> parameters = {
      'firstName': firstName,
      'lastName': lastName,
      'username': username,
      'email': email,
      'phoneNumber': phone,
      'password': password,
      'type': type,
      'companyName': companyName,
      'address': address,
      'postalCode': postalCode,
      'villa': villa,
      'tva': tva,
      'siren': siren,
      'category': category,
      'fax': fax,
      'website': website,
      'deliveryAddress': deliveryAddress,
      'deliveryPostalCode': deliveryPostalCode,
      'deliveryVilla': deliveryVilla,
      'note': note,
      'reliability': reliability,
      'discount': discount,
      'delayDelivery': delayDelivery,
      'freeShippingAmount': freeShippingCosts,
      'shippingCosts': shippingCost,
      'hours': hours,
      'codeNaf': codeNaf,
      'earlSas': sarl,
      'contact': contact,
      'iban': iban,
      'bic': bic,
      'bank': bank,
    };
    return jsonDecode(
        (await sendPostRequest(_createClientUrl, parameters)).body);
  }
  static Future<dynamic> editClient({
    String? clientId,
    String? firstName,
    String? lastName,
    String? username,
    String? email,
    String? phone,
    String? password,
    String? type,
    String? companyName,
    String? fax,
    String? website,
    String? note,
    String? category,
    String? address,
    String? postalCode,
    String? villa,
    String? deliveryAddress,
    String? deliveryPostalCode,
    String? deliveryVilla,
    String? reliability,
    String? discount,
    String? delayDelivery,
    String? shippingCost,
    String? freeShippingCosts,
    String? hours,
    String? tva,
    String? siren,
    String? codeNaf,
    String? rcs,
    String? sarl,
    String? contact,
    String? iban,
    String? bic,
    String? bank,
  }) async {
    Map<String, dynamic> parameters = {
      'firstName': firstName,
      'lastName': lastName,
      'username': username,
      'email': email,
      'phoneNumber': phone,
      'password': password,
      'type': type,
      'companyName': companyName,
      'address': address,
      'postalCode': postalCode,
      'villa': villa,
      'tva': tva,
      'siren': siren,
      'category': category,
      'fax': fax,
      'website': website,
      'deliveryAddress': deliveryAddress,
      'deliveryPostalCode': deliveryPostalCode,
      'deliveryVilla': deliveryVilla,
      'note': note,
      'reliability': reliability,
      'discount': discount,
      'delayDelivery': delayDelivery,
      'freeShippingAmount': freeShippingCosts,
      'shippingCosts': shippingCost,
      'hours': hours,
      'codeNaf': codeNaf,
      'earlSas': sarl,
      'contact': contact,
      'iban': iban,
      'bic': bic,
      'bank': bank,
    };
    return jsonDecode(
        (await sendPutRequest("$_clientUrl/$clientId", parameters)).body);
  }


  static Future<dynamic> deleteClient({
    required String id,
  }) async {
    return jsonDecode((await sendDeleteRequest('$_clientUrl/$id')).body);
  }

  static Future<ItemsModel> getItems({
    String page = '1',
    String limit = '10',
    String query = '',
    String? clientId,
  }) async {
    Map<String, dynamic> parameters = {
      "page": page,
      "limit": limit,
      "query": query,
      "clientId": clientId
    };
    return ItemsModel.fromJson(json
        .decode((await sendGetRequest(_itemsUrl + toQuery(parameters))).body));
  }

  static Future<dynamic> getItemByBarcode({
    String? barcode,
  }) async {
    Map<String, dynamic> parameters = {
      "barcode": barcode,
    };
    return json
        .decode((await sendGetRequest("$_itemsUrl/item_by_code${toQuery(parameters)}")).body);
  }

  static Future<dynamic> getStockByBarcode({
    String? barcode,
  }) async {
    Map<String, dynamic> parameters = {
      "barcode": barcode,
    };
    return json.decode(
        (await sendGetRequest("$_stockUrl/stock_by_code${toQuery(parameters)}"))
            .body);
  }

  static Future<dynamic> deleteItem({
    required String id,
  }) async {
    return jsonDecode((await sendDeleteRequest('$_itemsUrl/$id')).body);
  }
  static Future<dynamic> createItem(
      {required String designation,
      required String sku,
      required String clientId,
      required String type,
      required String barcode,
      String? categoryId,
      String? width,
      String? height,
      String? depth,
      String? weight,
      List? children}) async {
    Map<String, dynamic> parameters = {
      'designation': designation,
      'sku': sku,
      'clientId': clientId,
      'type': type,
      'barcode': barcode,
      'categoryId': categoryId,
      "width": width,
      "height": height,
      "depth": depth,
      "weight": weight,
      "children": jsonEncode(children)
    };

    return jsonDecode((await sendPostRequest(_createItemUrl, parameters)).body);
  }

  static Future<ShipmentsModel> getShipments({
    String page = '1',
    String limit = '10',
    String query = '',
    String? clientId,
  }) async {
    Map<String, dynamic> parameters = {
      "page": page,
      "limit": limit,
      "query": query,
      "clientId": clientId
    };
    return ShipmentsModel.fromJson(json.decode(
        (await sendGetRequest(_shipmentsUrl + toQuery(parameters))).body));
  }

  static Future<ShipmentDetailsModel> getShipmentDetails({
    String? shipmentId = '',
  }) async {
    Map<String, String> parameters = {};
    return ShipmentDetailsModel.fromJson(json.decode((await sendGetRequest(
            "$_shipmentUrl/$shipmentId${toQuery(parameters)}"))
        .body));
  }

  static Future<dynamic> editShipment({
    String? arrivalDate,
    String? status,
    String? container,
    required String shipmentId,
  }) async {
    Map<String, dynamic> parameters = {
      "arrivalDate": arrivalDate,
      "status": status,
      "container": container,
    };

    return jsonDecode(
        (await sendPutRequest("$_shipmentsUrl/$shipmentId", parameters)).body);
  }

  static Future<dynamic> receiveItem({
    required String id,
    required String itemId,
    required String shipmentId,
    required List locations,
  }) async {
    Map<String, dynamic> parameters = {
      'itemId': itemId,
      'shipmentId': shipmentId,
      'locations': jsonEncode(locations),
    };
    return jsonDecode(
        (await sendPostRequest("$_receiveItemUrl/$id", parameters)).body);
  }

  static Future<dynamic> createEntryShipment(
      {required String clientId,
      required String arrivalDate,
      String? container,
      String? description,
      List? items}) async {
    Map<String, dynamic> parameters = {
      'clientId': clientId,
      'arrivalDate': arrivalDate,
      'description': description,
      'container': container,
      "items": jsonEncode(items)
    };

    return jsonDecode(
        (await sendPostRequest(_entryShipmentUrl, parameters)).body);
  }

  static Future<dynamic> completeShipment({
    required String shipmentId,
  }) async {
    Map<String, dynamic> parameters = {};
    return jsonDecode(
        (await sendPostRequest("$_completeShipmentUrl/$shipmentId", parameters))
            .body);
  }

  static Future<dynamic> deliverShipment({
    required String shipmentId,
  }) async {
    Map<String, dynamic> parameters = {};
    return jsonDecode(
        (await sendPostRequest("$_deliverShipmentUrl/$shipmentId", parameters))
            .body);
  }

  static Future<dynamic> createExitShipment(
      {required String clientId,
      required String destinationAddress,
      String? approClient,
      String? description,
      List? items}) async {
    Map<String, dynamic> parameters = {
      'clientId': clientId,
      'approClient': approClient,
      'destinationAddress': destinationAddress,
      'description': description,
      "items": jsonEncode(items)
    };

    return jsonDecode(
        (await sendPostRequest(_exitShipmentUrl, parameters)).body);
  }

  static Future<dynamic> createEntryVoucher(
      {String? numOfBe,
      String? transporter,
      String? clientId,
      String? refClient,
      String? truck,
      String? nPlomb,
      String? empPrinpcipal,
      String? shipper,
      String? shipperCity,
      String? receiver,
      String? receiverCity,
      String? infosIncoterm,
      String? reserves,
      String? voucherOrder,
      String? receiveDate,
      String? notes,
      String? receipt,
      bool? dang,
      bool? uno,
      bool? fridge,
      List? goods,
      List? dimensions,
      }) async {
    Map<String, dynamic> parameters = {
      'numBe': numOfBe,
      'transporter': transporter,
      'clientId': clientId,
      'refClient': refClient,
      'truck': truck,
      'nPlomb': nPlomb,
      'empPrinpcipal': empPrinpcipal,
      'shipper': shipper,
      'shipperCity': shipperCity,
      'receiver': receiver,
      'receiverCity': receiverCity,
      'infosIncoterm': infosIncoterm,
      'reserves': reserves,
      'voucherOrder': voucherOrder,
      'receiveDate': receiveDate,
      'notes': notes,
      'receipt': receipt,
      'dang': dang,
      'onu': uno,
      'fridge': fridge,
      'goods': jsonEncode(goods),
      'dimensions': jsonEncode(dimensions),
    };
    return jsonDecode((await sendPostRequest(_vouchersUrl, parameters)).body);
  }

}

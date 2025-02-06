class RecentOrders {
  final String user;
  final int orderId;
  final String deliveryboyname;
  final String invoice;
  final String invoicedate;
  final String status;
  final int amount;

  RecentOrders(
      {required this.orderId,
      required this.user,
      required this.amount,
      required this.deliveryboyname,
      required this.invoice,
      required this.invoicedate,
      required this.status});
}

List<RecentOrders> orders = [
  RecentOrders(
      orderId: 1,
      user: 'Jishnu',
      amount: 500,
      deliveryboyname: "Sasi",
      invoice: "INV001",
      invoicedate: '16/6/2023',
      status: "Delivered"),
  RecentOrders(
      orderId: 2,
      user: 'Rahul',
      amount: 750,
      deliveryboyname: "Akhil",
      invoice: "INV002",
      invoicedate: '17/6/2023',
      status: "Pending"),
  RecentOrders(
      orderId: 3,
      user: 'Arjun',
      amount: 1200,
      deliveryboyname: "Manu",
      invoice: "INV003",
      invoicedate: '18/6/2023',
      status: "Cancelled"),
  RecentOrders(
      orderId: 4,
      user: 'Vishnu',
      amount: 300,
      deliveryboyname: "Babu",
      invoice: "INV004",
      invoicedate: '19/6/2023',
      status: "Processing"),
  RecentOrders(
      orderId: 5,
      user: 'Anjali',
      amount: 900,
      deliveryboyname: "Suresh",
      invoice: "INV005",
      invoicedate: '20/6/2023',
      status: "Shipped"),
  RecentOrders(
      orderId: 6,
      user: 'Neha',
      amount: 650,
      deliveryboyname: "Ravi",
      invoice: "INV006",
      invoicedate: '21/6/2023',
      status: "Delivered"),
  RecentOrders(
      orderId: 1,
      user: 'Jishnu',
      amount: 500,
      deliveryboyname: "Sasi",
      invoice: "INV001",
      invoicedate: '16/6/2023',
      status: "Delivered"),
  RecentOrders(
      orderId: 2,
      user: 'Rahul',
      amount: 750,
      deliveryboyname: "Akhil",
      invoice: "INV002",
      invoicedate: '17/6/2023',
      status: "Pending"),
  RecentOrders(
      orderId: 3,
      user: 'Arjun',
      amount: 1200,
      deliveryboyname: "Manu",
      invoice: "INV003",
      invoicedate: '18/6/2023',
      status: "Cancelled"),
  RecentOrders(
      orderId: 4,
      user: 'Vishnu',
      amount: 300,
      deliveryboyname: "Babu",
      invoice: "INV004",
      invoicedate: '19/6/2023',
      status: "Processing"),
  RecentOrders(
      orderId: 5,
      user: 'Anjali',
      amount: 900,
      deliveryboyname: "Suresh",
      invoice: "INV005",
      invoicedate: '20/6/2023',
      status: "Shipped"),
  RecentOrders(
      orderId: 6,
      user: 'Neha',
      amount: 650,
      deliveryboyname: "Ravi",
      invoice: "INV006",
      invoicedate: '21/6/2023',
      status: "Delivered"),
  RecentOrders(
      orderId: 1,
      user: 'Jishnu',
      amount: 500,
      deliveryboyname: "Sasi",
      invoice: "INV001",
      invoicedate: '16/6/2023',
      status: "Delivered"),
  RecentOrders(
      orderId: 2,
      user: 'Rahul',
      amount: 750,
      deliveryboyname: "Akhil",
      invoice: "INV002",
      invoicedate: '17/6/2023',
      status: "Pending"),
  RecentOrders(
      orderId: 3,
      user: 'Arjun',
      amount: 1200,
      deliveryboyname: "Manu",
      invoice: "INV003",
      invoicedate: '18/6/2023',
      status: "Cancelled"),
  RecentOrders(
      orderId: 4,
      user: 'Vishnu',
      amount: 300,
      deliveryboyname: "Babu",
      invoice: "INV004",
      invoicedate: '19/6/2023',
      status: "Processing"),
  RecentOrders(
      orderId: 5,
      user: 'Anjali',
      amount: 900,
      deliveryboyname: "Suresh",
      invoice: "INV005",
      invoicedate: '20/6/2023',
      status: "Shipped"),
  RecentOrders(
      orderId: 6,
      user: 'Neha',
      amount: 650,
      deliveryboyname: "Ravi",
      invoice: "INV006",
      invoicedate: '21/6/2023',
      status: "Delivered"),
];

Message-ID: <13229820.1120126061358.JavaMail.www@wwinf4101>
From: shenry82 <shenry82@voila.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Date: Thu, 30 Jun 2005 12:07:41 +0200 (CEST)
Content-Transfer-Encoding: quoted-printable
Subject: [Bridge] STP Explanation
Reply-To: shenry82@voila.fr
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Hi,

    I'm trying to modify the stp kernel files in order to implements the RS=
TP. I've already modify the bpdu format like this :
---------------------------------------------------------------------------=
---------------------------------------------------------
typedef struct
{
  int	topo_change =3D 0;
  int	proposal =3D 0;
  int	port_role[2] =3D {0,0} ; //role du port =E9metteur du BPDU initialis=
=E9 =E0 UNKNOWN
  int	learning =3D 0;
  int   forwarding =3D 0;
  int   agreement =3D 0;
  int   topo_change_ack =3D 0;
}bpdu_flag;

typedef struct=20
{
  unsigned char protocol[2]=3D {0x00,0x00}; // le type unsigned char peut =
=EAtre assimil=E9 =E0 un octet
  unsigned char version =3D 0x02; //convention
  unsigned char bpdu_type;
} bpdu_header;

typedef struct=20
{
  bpdu_flag 	flags;
  unsigned char root_id[8];
  unsigned char root_path_cost[4];
  unsigned char bridge_id[8];
  unsigned char port_id[2];
  unsigned char message_age[2];
  unsigned char max_age[2];
  unsigned char hello_time[2];
  unsigned char forward_delay[2];
} bpdu_body;

typedef struct
{
  bpdu_header hdr;
  bpdu_body   body;
  unsigned char ver_1_len[2];// ?
}bpdu;
---------------------------------------------------------------------------=
-----------------------------------------------

but i'm perplex with this following function in br_stp_bpdu.c :
---------------------------------------------------------------------------=
----------------------------------------------
void br_send_config_bpdu(struct net_bridge_port *p, struct bpdu *bpdu)
{
	unsigned char buf[38];

	buf[0] =3D 0x42;
	buf[1] =3D 0x42;
	buf[2] =3D 0x03;
	buf[3] =3D 0;
	buf[4] =3D 0;
	buf[5] =3D 0;
	buf[6] =3D BPDU_TYPE_CONFIG;
	buf[7] =3D (bpdu->topology_change ? 0x01 : 0) |
		(bpdu->topology_change_ack ? 0x80 : 0);
	buf[8] =3D bpdu->root.prio[0];
	buf[9] =3D bpdu->root.prio[1];
	buf[10] =3D bpdu->root.addr[0];
	buf[11] =3D bpdu->root.addr[1];
	buf[12] =3D bpdu->root.addr[2];
	buf[13] =3D bpdu->root.addr[3];
	buf[14] =3D bpdu->root.addr[4];
	buf[15] =3D bpdu->root.addr[5];
	buf[16] =3D (bpdu->root_path_cost >> 24) & 0xFF;
	buf[17] =3D (bpdu->root_path_cost >> 16) & 0xFF;
	buf[18] =3D (bpdu->root_path_cost >> 8) & 0xFF;
	buf[19] =3D bpdu->root_path_cost & 0xFF;
	buf[20] =3D bpdu->bridge_id.prio[0];
	buf[21] =3D bpdu->bridge_id.prio[1];
	buf[22] =3D bpdu->bridge_id.addr[0];
	buf[23] =3D bpdu->bridge_id.addr[1];
	buf[24] =3D bpdu->bridge_id.addr[2];
	buf[25] =3D bpdu->bridge_id.addr[3];
	buf[26] =3D bpdu->bridge_id.addr[4];
	buf[27] =3D bpdu->bridge_id.addr[5];
	buf[28] =3D (bpdu->port_id >> 8) & 0xFF;
	buf[29] =3D bpdu->port_id & 0xFF;

	br_set_ticks(buf+30, bpdu->message_age);
	br_set_ticks(buf+32, bpdu->max_age);
	br_set_ticks(buf+34, bpdu->hello_time);
	br_set_ticks(buf+36, bpdu->forward_delay);

	br_send_bpdu(p, buf, 38);
}
---------------------------------------------------------------------------=
-----

Indeed I don't understand the default value from buffer[0] to buffer[7] bec=
ause if I follow my new structure of bpdu i would have :
---------------------------------------------------------------------------=
-----------------------------------------------------
void br_send_config_bpdu(struct net_bridge_port *p, struct bpdu *bpdu)
{
	unsigned char buf[42];

	buf[0] =3D bpdu->bpdu_header->protocol[0]; //0x00
	buf[1] =3D bpdu->bpdu_header->protocol[1]; //0x00
	buf[2] =3D bpdu->bpdu_header->version; //0x02
	buf[3] =3D BPDU_TYPE_CONFIG;
	buf[4] =3D bpdu->bpdu_body->flags->topo_change;
	buf[5] =3D bpdu->bpdu_body->flags->proposal;
	buf[6] =3D bpdu->bpdu_body->flags->port_role[0];
	buf[7] =3D bpdu->bpdu_body->flags->port_role[1];
	buf[8] =3D bpdu->bpdu_body->flags->learning;
	buf[9] =3D bpdu->bpdu_body->flags->forwarding;
	buf[10] =3D bpdu->bpdu_body->flags->agreement;
	buf[11] =3D bpdu->bpdu_body->flags->topo_change_ack;=09
	buf[12] =3D bpdu->root.prio[0];
	buf[13] =3D bpdu->root.prio[1];
	buf[14] =3D bpdu->root.addr[0];
	buf[15] =3D bpdu->root.addr[1];
	buf[16] =3D bpdu->root.addr[2];
	buf[17] =3D bpdu->root.addr[3];
	buf[18] =3D bpdu->root.addr[4];
	buf[19] =3D bpdu->root.addr[5];
	buf[20] =3D (bpdu->root_path_cost >> 24) & 0xFF;
	buf[21] =3D (bpdu->root_path_cost >> 16) & 0xFF;
	buf[22] =3D (bpdu->root_path_cost >> 8) & 0xFF;
	buf[23] =3D bpdu->root_path_cost & 0xFF;
	buf[24] =3D bpdu->bridge_id.prio[0];
	buf[25] =3D bpdu->bridge_id.prio[1];
	buf[26] =3D bpdu->bridge_id.addr[0];
	buf[27] =3D bpdu->bridge_id.addr[1];
	buf[28] =3D bpdu->bridge_id.addr[2];
	buf[29] =3D bpdu->bridge_id.addr[3];
	buf[30] =3D bpdu->bridge_id.addr[4];
	buf[31] =3D bpdu->bridge_id.addr[5];
	buf[32] =3D (bpdu->port_id >> 8) & 0xFF;
	buf[33] =3D bpdu->port_id & 0xFF;

	br_set_ticks(buf+34, bpdu->message_age);
	br_set_ticks(buf+36, bpdu->max_age);
	br_set_ticks(buf+38, bpdu->hello_time);
	br_set_ticks(buf+40, bpdu->forward_delay);

	br_send_bpdu(p, buf, 42);
}
---------------------------------------------------------------------------=
----------------------

what do you think of it ?

thanks

Simon Henry


------------------------------------------

Faites un voeu et puis Voila ! www.voila.fr=20





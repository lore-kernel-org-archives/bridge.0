Message-ID: <5403437.1120128719825.JavaMail.www@wwinf4104>
From: shenry82 <shenry82@voila.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Date: Thu, 30 Jun 2005 12:51:59 +0200 (CEST)
Subject: [Bridge] STP Explanation (2)
Reply-To: shenry82@voila.fr
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Bridge@lists.osdl.org

I saw some big mistakes, here's the correct version :
--------------------------------------------------------------------
void br_send_config_bpdu(struct net_bridge_port *p, struct bpdu *bpdu)
{
	unsigned char buf[42];

	buf[0] = bpdu->bpdu_header.protocol[0]; //0x00
	buf[1] = bpdu->bpdu_header.protocol[1]; //0x00
	buf[2] = bpdu->bpdu_header.version; //0x02
	buf[3] = BPDU_TYPE_CONFIG;
	buf[4] = bpdu->bpdu_body.flags.topo_change;
	buf[5] = bpdu->bpdu_body.flags.proposal;
	buf[6] = bpdu->bpdu_body.flags.port_role[0];
	buf[7] = bpdu->bpdu_body.flags.port_role[1];
	buf[8] = bpdu->bpdu_body.flags.learning;
	buf[9] = bpdu->bpdu_body.flags.forwarding;
	buf[10] = bpdu->bpdu_body.flags.agreement;
	buf[11] = bpdu->bpdu_body.flags.topo_change_ack;	
	buf[12] = bpdu->bpdu_body.root_id.prio[0];
	buf[13] = bpdu->bpdu_body.root_id.prio[1];
	buf[14] = bpdu->bpdu_body.root_id.addr[0];
	buf[15] = bpdu->bpdu_body.root_id.addr[1];
	buf[16] = bpdu->bpdu_body.root_id.addr[2];
	buf[17] = bpdu->bpdu_body.root_id.addr[3];
	buf[18] = bpdu->bpdu_body.root_id.addr[4];
	buf[19] = bpdu->bpdu_body.root_id.addr[5];
	buf[20] = (bpdu->bpdu_body.root_path_cost >> 24) & 0xFF;
	buf[21] = (bpdu->bpdu_body.root_path_cost >> 16) & 0xFF;
	buf[22] = (bpdu->bpdu_body.root_path_cost >> 8) & 0xFF;
	buf[23] = bpdu->bpdu_body.root_path_cost & 0xFF;
	buf[24] = bpdu->bpdu_body.bridge_id.prio[0];
	buf[25] = bpdu->bpdu_body.bridge_id.prio[1];
	buf[26] = bpdu->bpdu_body.bridge_id.addr[0];
	buf[27] = bpdu->bpdu_body.bridge_id.addr[1];
	buf[28] = bpdu->bpdu_body.bridge_id.addr[2];
	buf[29] = bpdu->bpdu_body.bridge_id.addr[3];
	buf[30] = bpdu->bpdu_body.bridge_id.addr[4];
	buf[31] = bpdu->bpdu_body.bridge_id.addr[5];
	buf[32] = (bpdu->bpdu_body.port_id >> 8) & 0xFF;
	buf[33] = bpdu->bpdu_body.port_id & 0xFF;

	br_set_ticks(buf+34, bpdu->bpdu_body.message_age);
	br_set_ticks(buf+36, bpdu->bpdu_body.max_age);
	br_set_ticks(buf+38, bpdu->bpdu_body.hello_time);
	br_set_ticks(buf+40, bpdu->bpdu_body.forward_delay);

	br_send_bpdu(p, buf, 42);
}
-------------------------------------------------------------------------
I also modified the following function like this :
------------------------------------------------------------------------------
/* called under bridge lock */
void br_send_tcn_bpdu(struct net_bridge_port *p)
{
	unsigned char buf[4];

	buf[0] = bpdu->bpdu_header.protocol[0]; //0x00
	buf[1] = bpdu->bpdu_header.protocol[1]; //0x00
	buf[2] = bpdu->bpdu_header.version; //0x02
	buf[3] = BPDU_TYPE_TCN;
	br_send_bpdu(p, buf, 4);
}

static unsigned char header[3] = {0x00, 0x00, 0x02};
------------------------------------------------------------------------

please tell me what do you think of because if i'm getting the wrong way, i prefer to know it quickly. ^^

regards,

Simon Henry
------------------------------------------

Faites un voeu et puis Voila ! www.voila.fr 




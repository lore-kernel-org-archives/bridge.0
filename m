Message-ID: <2534666.1120128861241.JavaMail.www@wwinf4104>
From: shenry82 <shenry82@voila.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Date: Thu, 30 Jun 2005 12:54:21 +0200 (CEST)
Subject: [Bridge] STP Explanation (3)
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

I forgot the bdpu_body structure modification in the last message, sorry here it is :
---------------------------------------------------------------------------
typedef struct 
{
  bpdu_flag 	flags;
  bridge_id	root_id[8];
  unsigned char root_path_cost[4];
  bridge_id     bridge_id[8];
  unsigned char port_id[2];
  unsigned char message_age[2];
  unsigned char max_age[2];
  unsigned char hello_time[2];
  unsigned char forward_delay[2];
} bpdu_body;
---------------------------------------------------------------------
------------------------------------------

Faites un voeu et puis Voila ! www.voila.fr 




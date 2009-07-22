Message-ID: <4A6778D3.3050805@free.fr>
Date: Wed, 22 Jul 2009 22:38:43 +0200
From: =?UTF-8?B?Tmljb2xhcyBkZSBQZXNsb8O8YW4=?=
 <nicolas.2p.debian@free.fr>
MIME-Version: 1.0
References: <574163.2033.qm@web8805.mail.in.yahoo.com>
In-Reply-To: <574163.2033.qm@web8805.mail.in.yahoo.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] Help Needed for ebtables.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: rahul bhardwaj <rahul_bhardwaj36in@yahoo.co.in>
Cc: bridge@lists.linux-foundation.org

rahul bhardwaj wrote:
> Hi All,
> 
> We are planning to add a feature to not allow the hosts connected to the 
> same gateway to communicate with each other – Would ebtables be a good 
> option to implement (on the gateway) it. Could we do it by adding a rule 
> in the ebtables for dropping a frame based on it’s destination MAC 
> address if it is there in the list of forbidden MACs. We could add to 
> this list the MAC address of each station that joins the network. Let me 
> know what you think
> 

Read the thread with subject "[Bridge] RFC: Simple Private VLAN impl." 
started on june, 10th.

HTH.

	Nicolas.

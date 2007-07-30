Message-ID: <46AE21A4.4000501@schaus.ca>
Date: Mon, 30 Jul 2007 11:36:36 -0600
From: Cameron Schaus <cam@schaus.ca>
MIME-Version: 1.0
Subject: Re: [Bridge] VLAN header accounting for packets leaving bridge
References: <46AE1668.9070804@schaus.ca> <20070730181137.2bf6a4e8@oldman>
In-Reply-To: <20070730181137.2bf6a4e8@oldman>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: bridge@linux-foundation.org

Stephen Hemminger wrote:
> This might break VLAN transparent bridging (ie. when eth0 is bridged to eth1
> and the bridge doesn't know or care about vlan's). There is also the case
> where packet comes in over VLAN and goes out without tag.
>   
I was definitely worried about the first case you mentioned.  However, 
the nf_bridge_copy_header function does the same skb_push taking into 
account the 8021Q header size, if it's called.

In light of the cases you mentioned above, would it be best to just 
alter the data pointer in the ebtables module to take into account the 
new vlan header?  I hesitate to do this because doing so could affect 
other rules run after the modification, if any.

Cam


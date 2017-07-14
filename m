Return-Path: <makita.toshiaki@lab.ntt.co.jp>
References: <1499951350-2087-1-git-send-email-nikolay@cumulusnetworks.com>
From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Message-ID: <c5558df7-c1f3-d130-3d91-e3e423a669b1@lab.ntt.co.jp>
Date: Fri, 14 Jul 2017 10:02:33 +0900
MIME-Version: 1.0
In-Reply-To: <1499951350-2087-1-git-send-email-nikolay@cumulusnetworks.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net] net: bridge: fix dest lookup when vlan
 proto doesn't match
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, netdev@vger.kernel.org
Cc: bridge@lists.linux-foundation.org, roopa@cumulusnetworks.com, anitha@cumulusnetworks.com, davem@davemloft.net

On 2017/07/13 22:09, Nikolay Aleksandrov wrote:
> With 802.1ad support the vlan_ingress code started checking for vlan
> protocol mismatch which causes the current tag to be inserted and the
> bridge vlan protocol & pvid to be set. The vlan tag insertion changes
> the skb mac_header and thus the lookup mac dest pointer which was loaded
> prior to calling br_allowed_ingress in br_handle_frame_finish is VLAN_HLEN
> bytes off now, pointing to the last two bytes of the destination mac and
> the first four of the source mac causing lookups to always fail and
> broadcasting all such packets to all ports. Same thing happens for locally
> originated packets when passing via br_dev_xmit. So load the dest pointer
> after the vlan checks and possible skb change.
> 
> Fixes: 8580e2117c06 ("bridge: Prepare for 802.1ad vlan filtering support")
> Reported-by: Anitha Narasimha Murthy <anitha@cumulusnetworks.com>
> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

Oops. Thank you for fixing it.

Acked-by: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>


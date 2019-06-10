Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=E/V+F42zy5zDKXGy0YG+Ock4S+/7BVw/qPxdB1U2uGs=;
	b=RSLSKKk0Jh+zqrNJW4rQrIzFfUaR2OwteUKHFydDh+k1VWL0Gdjei10FjpMsTD6LQx
	K0D/wl1ro0m3nkYc3AFFzOyn5g5VBXMkQgaVP4RnrLgoFYX5q1W3nXnM+xDtca3Y+AXw
	7w06UdyA+BT1AON8gHw3iRKpXf6CamR2Q7hdY=
References: <1560159846-29933-1-git-send-email-wenxu@ucloud.cn>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <55b99afa-7ce5-f9e3-89fb-6f3d17985519@cumulusnetworks.com>
Date: Mon, 10 Jun 2019 18:21:32 +0300
MIME-Version: 1.0
In-Reply-To: <1560159846-29933-1-git-send-email-wenxu@ucloud.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] bridge: Set the pvid for untaged
 packet before prerouting
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: wenxu@ucloud.cn, roopa@cumulusnetworks.com
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org

On 10/06/2019 12:44, wenxu@ucloud.cn wrote:
> From: wenxu <wenxu@ucloud.cn>
> 
> bridge vlan add dev veth1 vid 200 pvid untagged
> bridge vlan add dev veth2 vid 200 pvid untagged
> 
> nft add table bridge firewall
> nft add chain bridge firewall zones { type filter hook prerouting priority - 300 \; }
> nft add rule bridge firewall zones counter ct zone set vlan id map { 100 : 1, 200 : 2 }
> 
> As above set the bridge port with pvid, the received packet don't contain
> the vlan tag which means the packet should belong to vlan 200 through pvid.
> User can do conntrack base base on vlan id and map the vlan id to zone id
> in the prerouting hook.
> 
> Signed-off-by: wenxu <wenxu@ucloud.cn>
> ---
>  net/bridge/br_input.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Nacked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

Hi,
I don't think this is a good idea for a few reasons:
- duplicating code (pvid insertion by __allowed_ingress)
- adding 2 new tests in the fast path (even 3 in the vlan filtering case)
- issue can be solved with current state by using different config

Why do you need the vid to be set when you can assume that all the traffic from
that port belongs to the pvid vlan ? In this case you can match the port ifindex
for example and associate the zones based on that. Another approach - you can
insert the vlan by tc's vlan action on ingress, you'll get the same effect.

Overall this looks like an issue solvable by different config instead of adding new tests
in the fast path and increasing the complexity of the bridge input code for little value.

Cheers,
 Nik



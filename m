Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=+0u6Co0fQyRE3E7Gd5FQVT98igTbdpT+/KuuR/oOF0o=;
 b=Lq8UN195SQC5IPnKOEO6l2YcI/XCWCeTBJOiTVUrQdQOxiP1flbaAf6YI7ybUg0SOA
 dwWdS7QqjCMOmLJLxYO9qocWPkMdotKnjr6RgpNBqCZCnXClXC3jLNldc/IQA+E+3MUV
 2Jp3+81U9+l4tJimSqzZviLR8KKZnBDgM0376nX7/uC7oEaGV/Hn04khLJNVivyigVpH
 iW8ubOhHKXxNL4H3rajYGJWeI0v97YfuINgV/bZ/7KBkZJWx53bJnbt6x94JjnHR90I5
 oB7xrGGWksa6RaAYGX1M3n17tWudAnT3kuqPqhxmx67tDvpt5R4MbvUlR8yqnaQMyFrP
 uPaQ==
Message-ID: <b3a94a42-1333-1393-1946-e6412d6830d5@blackwall.org>
Date: Thu, 19 May 2022 00:43:12 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <20220518005840.771575-1-andrew@lunn.ch>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20220518005840.771575-1-andrew@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v2 net] net: bridge: Clear offload_fwd_mark
 when passing frame up bridge interface.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Andrew Lunn <andrew@lunn.ch>, netdev <netdev@vger.kernel.org>
Cc: Ido Schimmel <idosch@mellanox.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, bridge@lists.linux-foundation.org

On 18/05/2022 03:58, Andrew Lunn wrote:
> It is possible to stack bridges on top of each other. Consider the
> following which makes use of an Ethernet switch:
> 
>        br1
>      /    \
>     /      \
>    /        \
>  br0.11    wlan0
>    |
>    br0
>  /  |  \
> p1  p2  p3
> 
> br0 is offloaded to the switch. Above br0 is a vlan interface, for
> vlan 11. This vlan interface is then a slave of br1. br1 also has a
> wireless interface as a slave. This setup trunks wireless lan traffic
> over the copper network inside a VLAN.
> 
> A frame received on p1 which is passed up to the bridge has the
> skb->offload_fwd_mark flag set to true, indicating that the switch has
> dealt with forwarding the frame out ports p2 and p3 as needed. This
> flag instructs the software bridge it does not need to pass the frame
> back down again. However, the flag is not getting reset when the frame
> is passed upwards. As a result br1 sees the flag, wrongly interprets
> it, and fails to forward the frame to wlan0.
> 
> When passing a frame upwards, clear the flag. This is the Rx
> equivalent of br_switchdev_frame_unmark() in br_dev_xmit().
> 
> Fixes: f1c2eddf4cb6 ("bridge: switchdev: Use an helper to clear forward mark")
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
> 
> v2:
> Extended the commit message with Ido obsersation of the equivelance of
> br_dev_xmit().
> 
> Fixed up the comment.
> 
> This code has passed Ido test setup.
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


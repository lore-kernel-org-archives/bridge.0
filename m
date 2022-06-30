Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E08AC60EFF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DBC3D60A90
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=xOuD0VayMLaVqMSm3qQEckL7M1TiFwHS72WWPKTLO58=;
 b=f2mg5NQcZInRzApmj3Hn1BwfNl1pudDvuPud+y6bW5QTphTs0bXap0Uu2pOmCLjt67
 13Xcr7cbtXO40QwP5BGR3/Lv14ByQi77QfcKQJTj7qwsgFHLYMfioS2b8xPcxClm0exN
 02p3T+AEeSkzysS7nxVSBskiMedr+oMz8YB+IB49n+wlv6Xw5o6bFyjETvnBcjFtmfNy
 WBv6ktj6+xlzz9y7+owgEUGG2ApUAOwv60wCPv8UVM8+o1cA2RPMvOR2txdT2PzZAaWo
 ijfpniC2e0HaioZ1VUHPbiJEFo37djO+X7EQpbklN41PWDjuWEwEMCoqLhxfyPvQhrkc
 8SRA==
Message-ID: <80d971ea-88b9-0d21-b6f4-93124ba6a678@blackwall.org>
Date: Thu, 30 Jun 2022 14:17:43 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <20220630111634.610320-1-hans@kapio-technology.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20220630111634.610320-1-hans@kapio-technology.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v1 1/1] net: bridge: ensure that
 link-local traffic cannot unlock a locked port
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Hans Schultz <hans@kapio-technology.com>, davem@davemloft.net, kuba@kernel.org
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux-foundation.org, Hans Schultz <schultz.hans+netdev@gmail.com>, linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, Paolo Abeni <pabeni@redhat.com>, Vladimir Oltean <olteanv@gmail.com>, Shuah Khan <shuah@kernel.org>, Vivien Didelot <vivien.didelot@gmail.com>

On 30/06/2022 14:16, Hans Schultz wrote:
> This patch is related to the patch set
> "Add support for locked bridge ports (for 802.1X)"
> Link: https://lore.kernel.org/netdev/20220223101650.1212814-1-schultz.hans+netdev@gmail.com/
> 
> This patch makes the locked port feature work with learning turned on,
> which is enabled with the command:
> 
> bridge link set dev DEV learning on
> 
> Without this patch, link local traffic (01:80:c2) like EAPOL packets will
> create a fdb entry when ingressing on a locked port with learning turned
> on, thus unintentionally opening up the port for traffic for the said MAC.
> 
> Some switchcore features like Mac-Auth and refreshing of FDB entries,
> require learning enables on some switchcores, f.ex. the mv88e6xxx family.
> Other features may apply too.
> 
> Since many switchcores trap or mirror various multicast packets to the
> CPU, link local traffic will unintentionally unlock the port for the
> SA mac in question unless prevented by this patch.
> 
> Signed-off-by: Hans Schultz <hans@kapio-technology.com>
> ---
>  net/bridge/br_input.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
> index 68b3e850bcb9..a3ce0a151817 100644
> --- a/net/bridge/br_input.c
> +++ b/net/bridge/br_input.c
> @@ -215,6 +215,7 @@ static void __br_handle_local_finish(struct sk_buff *skb)
>  	if ((p->flags & BR_LEARNING) &&
>  	    nbp_state_should_learn(p) &&
>  	    !br_opt_get(p->br, BROPT_NO_LL_LEARN) &&
> +	    !(p->flags & BR_PORT_LOCKED) &&
>  	    br_should_learn(p, skb, &vid))
>  		br_fdb_update(p->br, p, eth_hdr(skb)->h_source, vid, 0);
>  }

LGTM, thanks!
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

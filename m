Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 37ABB820F8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 77174820E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20221208.gappssmtp.com; s=20221208; t=1685371761; x=1687963761;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7Rzi88jwPmtFMmjNwM6+2TYx8VpaCHshCTn+VpfHMLE=;
 b=FAGhU7jW7A9tLI0VpW7atmg+20AaVVf4TyuPD/Y58xMx3EQzLKftc9ni7z1NaGkvju
 OrHyWynmv15DprInEjxybJkyRmVr5KeTP7voRFevHss47G0WbdBmYD1+c5W0lT7e5xtm
 AguMydpgy0f3C/X77K0c+raUC5DlZuUh93iSSaY6aSsvwUYv++TwqAwKCdUe2eoRL7gJ
 4oHnIY8HZdAANenhIgFkNl689NdEwJCxC0IslhM/lxl49E7V3srrCMIDbvNYjuDbaEFB
 nWIWq4utExJM4Eq8J7IGTwYNnhUcmX6s4NPKiqUwsooQZtSgSxboaTN0737Em+FNkKNi
 lEmg==
Message-ID: <3582538e-944e-3de6-6415-5384c399e0f5@blackwall.org>
Date: Mon, 29 May 2023 17:49:18 +0300
MIME-Version: 1.0
Content-Language: en-US
References: <20230529114835.372140-1-idosch@nvidia.com>
 <20230529114835.372140-6-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20230529114835.372140-6-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v2 5/8] mlxsw: spectrum_flower: Split
 iif parsing to a separate function
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: taras.chornyi@plvision.eu, petrm@nvidia.com, alexandre.belloni@bootlin.com, jiri@resnulli.us, leon@kernel.org, vladimir.oltean@nxp.com, roopa@nvidia.com, claudiu.manoil@nxp.com, UNGLinuxDriver@microchip.com, edumazet@google.com, jhs@mojatatu.com, xiyou.wangcong@gmail.com, simon.horman@corigine.com, kuba@kernel.org, pabeni@redhat.com, saeedm@nvidia.com, davem@davemloft.net

On 29/05/2023 14:48, Ido Schimmel wrote:
> Currently, mlxsw only supports the 'ingress_ifindex' field in the
> 'FLOW_DISSECTOR_KEY_META' key, but subsequent patches are going to add
> support for the 'l2_miss' field as well. Split the parsing of the
> 'ingress_ifindex' field to a separate function to avoid nesting. No
> functional changes intended.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
> 
> Notes:
>     v2:
>     * New patch.
> 
>  .../ethernet/mellanox/mlxsw/spectrum_flower.c | 54 +++++++++++--------
>  1 file changed, 33 insertions(+), 21 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>



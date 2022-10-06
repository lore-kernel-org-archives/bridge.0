Return-Path: <netdev@kapio-technology.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D490E6102C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BED6A60F3D
MIME-Version: 1.0
Date: Thu, 06 Oct 2022 14:24:17 +0200
From: netdev@kapio-technology.com
In-Reply-To: <20220928150256.115248-9-netdev@kapio-technology.com>
References: <20220928150256.115248-1-netdev@kapio-technology.com>
 <20220928150256.115248-9-netdev@kapio-technology.com>
Message-ID: <b5cdf29e7b5a5f7fa4ab1df4c5fd6e62@kapio-technology.com>
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v6 net-next 8/9] net: dsa: mv88e6xxx: add
 blackhole ATU entries
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: davem@davemloft.net, kuba@kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org, Joachim Wiberg <troglobit@gmail.com>, Shuah Khan <shuah@kernel.org>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Roopa Prabhu <roopa@nvidia.com>, Paolo Abeni <pabeni@redhat.com>, Vivien Didelot <vivien.didelot@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Amit Cohen <amcohen@nvidia.com>, Christian Marangi <ansuelsmth@gmail.com>, Hauke Mehrtens <hauke@hauke-m.de>, Hans Schultz <schultz.hans@gmail.com>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, Yuwei Wang <wangyuweihx@gmail.com>, Petr Machata <petrm@nvidia.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, Vladimir Oltean <olteanv@gmail.com>, Florent Fourcot <florent.fourcot@wifirst.fr>

On 2022-09-28 17:02, Hans Schultz wrote:
> From: "Hans J. Schultz" <netdev@kapio-technology.com>
> 
> Blackhole FDB entries can now be added, deleted or replaced in the
> driver ATU.
> 
> Signed-off-by: Hans J. Schultz <netdev@kapio-technology.com>
> ---
>  drivers/net/dsa/mv88e6xxx/chip.c | 78 ++++++++++++++++++++++++++++++--
>  1 file changed, 74 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/dsa/mv88e6xxx/chip.c 
> b/drivers/net/dsa/mv88e6xxx/chip.c
> index 71843fe87f77..a17f30e5d4a6 100644
> --- a/drivers/net/dsa/mv88e6xxx/chip.c
> +++ b/drivers/net/dsa/mv88e6xxx/chip.c
> @@ -2735,6 +2735,72 @@ static int mv88e6xxx_vlan_msti_set(struct 
> dsa_switch *ds,
>  	return err;
>  }
> 
> +struct mv88e6xxx_vid_search_ctx {
> +	u16 vid_search;
> +	u16 fid_found;
> +};
> +
> +static int mv88e6xxx_find_fid_on_matching_vid(struct mv88e6xxx_chip 
> *chip,
> +					      const struct mv88e6xxx_vtu_entry *entry,
> +					      void *priv)
> +{
> +	struct mv88e6xxx_vid_search_ctx *ctx = priv;
> +

FYI: I have already made updates to this part to use mv88e6xxx_vtu_get() 
instead of the walk, which also fixes a problem when vid=0 in this 
implementation.

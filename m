Return-Path: <simon.horman@corigine.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E32D783A51
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F160483A4F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oau6lH7G9gbb1rE7B99tsPTGyUdoKkSbNo3BtU/A9+k=;
 b=UtECUr4+Cx0+ttrCVYY2F2YlfxoaJFioXN3rMdSwT/NTVKEN1WyJSvH5Um5EhepbsvNSfnQivFiXVC3iTycJu/GwalXQgmYhTAsGKBATgm7K1MuU2gymvY+pyRNRKaD0/HSbEYDoO9LRJeMm6X2o6tCyWuFIBe4aqqTz8AheqfE=
Date: Fri, 19 May 2023 13:35:50 +0200
From: Simon Horman <simon.horman@corigine.com>
Message-ID: <ZGdfFuuPpaQs+Z5H@corigine.com>
References: <20230518113328.1952135-1-idosch@nvidia.com>
 <20230518113328.1952135-5-idosch@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518113328.1952135-5-idosch@nvidia.com>
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next 4/5] mlxsw: spectrum_flower: Add
 ability to match on layer 2 miss
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@nvidia.com>
Cc: taras.chornyi@plvision.eu, petrm@nvidia.com, alexandre.belloni@bootlin.com, jiri@resnulli.us, taspelund@nvidia.com, leon@kernel.org, netdev@vger.kernel.org, razor@blackwall.org, bridge@lists.linux-foundation.org, claudiu.manoil@nxp.com, UNGLinuxDriver@microchip.com, vladimir.oltean@nxp.com, xiyou.wangcong@gmail.com, edumazet@google.com, jhs@mojatatu.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, saeedm@nvidia.com, davem@davemloft.net

On Thu, May 18, 2023 at 02:33:27PM +0300, Ido Schimmel wrote:
> Add the 'dmac_type' key element to supported key blocks and make use of
> it to match on layer 2 miss.
> 
> This is a two bits key in hardware with the following values:
> 00b - Known multicast.
> 01b - Broadcast.
> 10b - Known unicast.
> 11b - Unknown unicast or unregistered multicast.
> 
> When 'l2_miss' is set we need to match on 01b or 11b. Therefore, only
> match on the LSB in order to differentiate between both cases of
> 'l2_miss'.
> 
> Tested on Spectrum-{1,2,3,4}.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>


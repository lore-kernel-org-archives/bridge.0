Return-Path: <Henrik.Bjoernlund@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1602508380; x=1634044380;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=WDNT8T0chASPmyuQTDcnmhl3GRuR4J/TIt+goiJGxHc=;
 b=cShTrUwyhlwIinKqzMf46ngu4thJ5t5NDQEP42mDm+BHz18azEo09E4L
 gbGvG9NE0FAfhWP1gYiGcuq43wI9ycj7UrL4VbWpufrLr6EV1DSg171LE
 xl3fQA/YAJytjuT/YeCvQ1nyeWPyRrGhJX2oN9jlSI5tMJvyywgdttOmL
 lxBhEeUPuuFIQH6AYmzCy3WJY1rvd2aJUVuN0w8/bRAZGfHq5Z2+rGF21
 VOqrNc2+GDGC43ZXpxv0CyHcKop4HMGcdPUdAOrXI7BseNpE5a55Ojbkn
 Ykf7V/Bnvquqv4OFpvSmcPG0gjYNoMS5o6FZTqdQD3hV/IWh7wEpTsGz7 w==;
Date: Mon, 12 Oct 2020 13:11:13 +0000
From: "henrik.bjoernlund@microchip.com" <henrik.bjoernlund@microchip.com>
Message-ID: <20201012131113.p54op2ku7r4l54bv@soft-test08>
References: <20201009143530.2438738-1-henrik.bjoernlund@microchip.com>
 <20201009143530.2438738-7-henrik.bjoernlund@microchip.com>
 <2ec76c98813c8190ced9e34b70b46d2dad94d714.camel@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <2ec76c98813c8190ced9e34b70b46d2dad94d714.camel@nvidia.com>
Subject: Re: [Bridge] [PATCH net-next v4 06/10] bridge: cfm: Kernel space
 implementation of CFM. CCM frame RX added.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@nvidia.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "UNGLinuxDriver@microchip.com" <UNGLinuxDriver@microchip.com>, "idosch@mellanox.com" <idosch@mellanox.com>, "jiri@mellanox.com" <jiri@mellanox.com>, Roopa Prabhu <roopa@nvidia.com>, "kuba@kernel.org" <kuba@kernel.org>, "horatiu.vultur@microchip.com" <horatiu.vultur@microchip.com>, "davem@davemloft.net" <davem@davemloft.net>

Thanks for the review.

The 10/09/2020 21:52, Nikolay Aleksandrov wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> On Fri, 2020-10-09 at 14:35 +0000, Henrik Bjoernlund wrote:
> > This is the third commit of the implementation of the CFM protocol
> > according to 802.1Q section 12.14.
> >
> > Functionality is extended with CCM frame reception.
> > The MEP instance now contains CCM based status information.
> > Most important is the CCM defect status indicating if correct
> > CCM frames are received with the expected interval.
> >
> > Signed-off-by: Henrik Bjoernlund  <henrik.bjoernlund@microchip.com>
> > Reviewed-by: Horatiu Vultur  <horatiu.vultur@microchip.com>
> > ---
> >  include/uapi/linux/cfm_bridge.h |  10 ++
> >  net/bridge/br_cfm.c             | 269 ++++++++++++++++++++++++++++++++
> >  net/bridge/br_private_cfm.h     |  32 ++++
> >  3 files changed, 311 insertions(+)
> >
> 
> Acked-by: Nikolay Aleksandrov <nikolay@nvidia.com>
> 
> 

-- 
/Henrik

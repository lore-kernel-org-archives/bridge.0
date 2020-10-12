Return-Path: <Henrik.Bjoernlund@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1602508486; x=1634044486;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=uXTNY8a8tuZF0KFVmfREJP/EwiyPuPGpWMVASP/6Lpg=;
 b=szOI02t0ZyS7Iu7YiLFHx8A5ILEoHETlaeEUb9ZLxO1dkMLpu2hc5Hsd
 p1yDnHaktl6DQ5+pJaOx9k0lUlpb+yvipyELo+SVwAN54tV0XBzyp7E4G
 KBCcEESt5VMle2BzMd7JAMvR9enKx6sMTej9pKq2yD6ww0xlMeDAV1HLh
 U35la75P+7TZ9H2QsBCZXc3ZpPs7TCtQaGqu7z6aCk6xIq+02WAy6NUFf
 L2Dg5iwfjNzbw4ikLLE4ou0hjChN4wmtIzXosiK/zMbMNcAOpdQNJWgk8
 usAFJZMBW5l30nbjp+mRyO9z3cqUGYHZQ7DXU8vG2ND+xUGFLgEDwzzOD w==;
Date: Mon, 12 Oct 2020 13:13:00 +0000
From: "henrik.bjoernlund@microchip.com" <henrik.bjoernlund@microchip.com>
Message-ID: <20201012131300.e7moweci4a475qa3@soft-test08>
References: <20201009143530.2438738-1-henrik.bjoernlund@microchip.com>
 <20201009143530.2438738-4-henrik.bjoernlund@microchip.com>
 <eda6fb9c0535077be89d2ee7dd9f7e12f730ef68.camel@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <eda6fb9c0535077be89d2ee7dd9f7e12f730ef68.camel@nvidia.com>
Subject: Re: [Bridge] [PATCH net-next v4 03/10] bridge: uapi: cfm: Added
 EtherType used by the CFM protocol.
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

The 10/09/2020 21:41, Nikolay Aleksandrov wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> On Fri, 2020-10-09 at 14:35 +0000, Henrik Bjoernlund wrote:
> > This EtherType is used by all CFM protocal frames transmitted
> > according to 802.1Q section 12.14.
> >
> > Signed-off-by: Henrik Bjoernlund  <henrik.bjoernlund@microchip.com>
> > Reviewed-by: Horatiu Vultur  <horatiu.vultur@microchip.com>
> > Acked-by: Nikolay Aleksandrov <nikolay@nvidia.com>
> > ---
> >  include/uapi/linux/if_ether.h | 1 +
> >  1 file changed, 1 insertion(+)
> >
> 
> Acked-by: Nikolay Aleksandrov <nikolay@nvidia.com>

-- 
/Henrik

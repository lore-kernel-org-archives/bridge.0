Return-Path: <Henrik.Bjoernlund@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1602508510; x=1634044510;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=WbHem3m4Q3i89Pivd83Tm6CpRpEgWOJlMqGFw8xU/Kg=;
 b=gUyuvq1tWYWRvRZxJhzDV2JiqMD8IUhDmMaLn1H78M3tze8K6G6/6fKG
 0Lxhpbd3ii3AL3Pfhx1RffWAaaN5rxfVxQO4GOLLfBjZ9fTY6oEOu+6U+
 8KaZ9SMgwqYj2iEmWFweJ/sEGqagFUxFlp7M6mfxifKrMhse/z91TNnfl
 9C65/+Yir2k7YPD2tmqpYhxA7S3s3V/c3KYGUGx50p2uWRwgGNOFrTzGo
 f3J9Phm3eYKx4MOWVSeLfB6so2/OXrF1Nox1GBKbT8/rYHxujad4GmYfq
 QWOCNUkaznMA3qqHgK2h50nhSZDQ9gWwHg5JE8HSjZserSTY4oWsgfrO7 Q==;
Date: Mon, 12 Oct 2020 13:13:24 +0000
From: "henrik.bjoernlund@microchip.com" <henrik.bjoernlund@microchip.com>
Message-ID: <20201012131324.qlxqxfpamievgrkz@soft-test08>
References: <20201009143530.2438738-1-henrik.bjoernlund@microchip.com>
 <20201009143530.2438738-3-henrik.bjoernlund@microchip.com>
 <f3e27f2363bf116ada0f352f263d6cbd051b6a87.camel@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <f3e27f2363bf116ada0f352f263d6cbd051b6a87.camel@nvidia.com>
Subject: Re: [Bridge] [PATCH net-next v4 02/10] bridge: cfm: Add BRIDGE_CFM
	to Kconfig.
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

The 10/09/2020 21:39, Nikolay Aleksandrov wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> On Fri, 2020-10-09 at 14:35 +0000, Henrik Bjoernlund wrote:
> > This makes it possible to include or exclude the CFM
> > protocol according to 802.1Q section 12.14.
> >
> > Signed-off-by: Henrik Bjoernlund  <henrik.bjoernlund@microchip.com>
> > Reviewed-by: Horatiu Vultur  <horatiu.vultur@microchip.com>
> > ---
> >  net/bridge/Kconfig      | 11 +++++++++++
> >  net/bridge/br_device.c  |  3 +++
> >  net/bridge/br_private.h |  3 +++
> >  3 files changed, 17 insertions(+)
> >
> 
> Acked-by: Nikolay Aleksandrov <nikolay@nvidia.com>
> 

-- 
/Henrik

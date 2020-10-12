Return-Path: <Henrik.Bjoernlund@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1602508410; x=1634044410;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=/uHY5C97UGg9fIbk/wKP58Fy+ohxLvbrLp3RjXnau48=;
 b=TtJEk/FRENJAgRXzOiXpEYCkwSPAnJkxkq4TOdLyruDSxepb/CtC1u9A
 uuwnLkiHdkX+pq68XFrOpRWQM1gn5HVKiGiBxm9Vivld65GGyxgKSMYRd
 tBF/VmewBeER1nFgAGiH3QUQ2pWvfG078Obk8cFBla6k4kLS/c+DhvBAc
 ftmgZL/shYFpZPuHJdRyFAqleitL2YHEmSyfvWbVnyHH8H1nacvEcVRM0
 bXjRYB6SDkm6CWpisxB04gnTcvfs0CGk6mHUgdmLFYvZwxqFacleBRwTf
 IDH7JUbSA2HSePn+dT114pdYccYMdAejB+KpaP4pf7exd2c9vCLRNHtSE Q==;
Date: Mon, 12 Oct 2020 13:11:44 +0000
From: "henrik.bjoernlund@microchip.com" <henrik.bjoernlund@microchip.com>
Message-ID: <20201012131144.rpqcx2iyt7jjkih3@soft-test08>
References: <20201009143530.2438738-1-henrik.bjoernlund@microchip.com>
 <20201009143530.2438738-6-henrik.bjoernlund@microchip.com>
 <a091e766d38c00ef4d70b3bc003e16dc3747789b.camel@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <a091e766d38c00ef4d70b3bc003e16dc3747789b.camel@nvidia.com>
Subject: Re: [Bridge] [PATCH net-next v4 05/10] bridge: cfm: Kernel space
 implementation of CFM. CCM frame TX added.
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

The 10/09/2020 21:49, Nikolay Aleksandrov wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> On Fri, 2020-10-09 at 14:35 +0000, Henrik Bjoernlund wrote:
> > This is the second commit of the implementation of the CFM protocol
> > according to 802.1Q section 12.14.
> >
> > Functionality is extended with CCM frame transmission.
> >
> > Interface is extended with these functions:
> > br_cfm_cc_rdi_set()
> > br_cfm_cc_ccm_tx()
> > br_cfm_cc_config_set()
> >
> > A MEP Continuity Check feature can be configured by
> > br_cfm_cc_config_set()
> >     The Continuity Check parameters can be configured to be used when
> >     transmitting CCM.
> >
> > A MEP can be configured to start or stop transmission of CCM frames by
> > br_cfm_cc_ccm_tx()
> >     The CCM will be transmitted for a selected period in seconds.
> >     Must call this function before timeout to keep transmission alive.
> >
> > A MEP transmitting CCM can be configured with inserted RDI in PDU by
> > br_cfm_cc_rdi_set()
> >
> > Signed-off-by: Henrik Bjoernlund  <henrik.bjoernlund@microchip.com>
> > Reviewed-by: Horatiu Vultur  <horatiu.vultur@microchip.com>
> > ---
> >  include/uapi/linux/cfm_bridge.h |  39 ++++-
> >  net/bridge/br_cfm.c             | 284 ++++++++++++++++++++++++++++++++
> >  net/bridge/br_private_cfm.h     |  54 ++++++
> >  3 files changed, 376 insertions(+), 1 deletion(-)
> >
> 
> Acked-by: Nikolay Aleksandrov <nikolay@nvidia.com>
> 

-- 
/Henrik

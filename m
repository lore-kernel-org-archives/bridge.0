Return-Path: <Henrik.Bjoernlund@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1602761658; x=1634297658;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=K5125LgfPLC5YBwpxAqbylzaGWeeFwuMFZBxHzf/rTw=;
 b=wkbhup4g577GBy+0njTbZ8q3fUUi6A2O8CVaXcFBhXpaqDVQcxsX5lCd
 RMIefncKby14pW+aA5sXLGOcWW3FsNO6nGmpefn4aDnrjbGS+bhsQve5b
 4Ppo4Mr/vXi7cKQrnQn25NqyZrj88yiibTWv42cMo1G41Hbls2Z5hc9OX
 I7Zil2JSgfghSnfbCvTIj5tyY/LSjnuBoIRJM2mC36l3zLQP9FnH+Ndd4
 TojOd9hjiVblU4o/b9KmiuOx8rBa4o0YZGL6DQ5LAMvb7qMj8Cf/euxFP
 W7ZYGJPqJrPKl2P9peUaKdVpFGjbtDaNSrlqPGWy5CSVc3ZUEhu+paTps A==;
Date: Thu, 15 Oct 2020 11:32:36 +0000
From: Henrik Bjoernlund <henrik.bjoernlund@microchip.com>
Message-ID: <20201015113236.iubkh5brahbkttio@soft-test08>
References: <20201012140428.2549163-1-henrik.bjoernlund@microchip.com>
 <20201014155847.2eb150f5@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201014155847.2eb150f5@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
Subject: Re: [Bridge] [PATCH net-next v5 00/10] net: bridge: cfm: Add
 support for Connectivity Fault Management(CFM)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, idosch@mellanox.com, jiri@mellanox.com, nikolay@nvidia.com, roopa@nvidia.com, Horatiu Vultur <horatiu.vultur@microchip.com>, davem@davemloft.net

Thanks for your review. Comments below.
Regards
Henrik

The 10/14/2020 15:58, Jakub Kicinski wrote:> 
> On Mon, 12 Oct 2020 14:04:18 +0000 Henrik Bjoernlund wrote:
> > Connectivity Fault Management (CFM) is defined in 802.1Q section 12.14.
> >
> > Connectivity Fault Management (CFM) comprises capabilities for detecting, verifying,
> > and isolating connectivity failures in Virtual Bridged Networks.
> > These capabilities can be used in networks operated by multiple independent organizations,
> > each with restricted management access to each other’s equipment.
> 
> Please wrap the cover letter and commit messages to 70 chars.
> 

I will do that,

> > Reviewed-by: Horatiu Vultur  <horatiu.vultur@microchip.com>
> > Signed-off-by: Henrik Bjoernlund  <henrik.bjoernlund@microchip.com>
> 
> You have two spaces after the name in many tags.

I will change as requested.

-- 
/Henrik

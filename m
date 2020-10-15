Return-Path: <kuba@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1602783274;
 bh=DNxvAuV7cKNsPEncClCJJJ0vr4kkwu9AJqh2X91MJ+I=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Ma63it46MNeYoPlFyYS5c1K5Cr4yl4b0mvpITcv+TdQSvEqmopd6R4HZanFaS0Ga3
 Sg9uHJdGQ51/ZZRXYNcxvJph/r1CpZQxyJWJzJhM7/JtRPWs7mYClAwKFR7Swjx7/8
 48jSLBH9u8JSFCL2ndfp0McKVKoUbsT8Lq397YIg=
Date: Thu, 15 Oct 2020 10:34:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
Message-ID: <20201015103431.25d66c8b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20201015115418.2711454-8-henrik.bjoernlund@microchip.com>
References: <20201015115418.2711454-1-henrik.bjoernlund@microchip.com>
 <20201015115418.2711454-8-henrik.bjoernlund@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v6 07/10] bridge: cfm: Netlink SET
 configuration Interface.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Henrik Bjoernlund <henrik.bjoernlund@microchip.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, idosch@mellanox.com, jiri@mellanox.com, nikolay@nvidia.com, roopa@nvidia.com, Horatiu Vultur <horatiu.vultur@microchip.com>, davem@davemloft.net

On Thu, 15 Oct 2020 11:54:15 +0000 Henrik Bjoernlund wrote:
> +	[IFLA_BRIDGE_CFM_MEP_CONFIG_MDLEVEL]	 = {
> +	.type = NLA_U32, .validation_type = NLA_VALIDATE_MAX, .max = 7 },

	NLA_POLICY_MAX(NLA_U32, 7)

Also why did you keep the validation in the code in patch 4?

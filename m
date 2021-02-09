Return-Path: <rasmus.villemoes@prevas.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LfEcprzb9pmLbsZ71aA6Z4Mf+YdFEouclDmvmJT40Fs=;
 b=DojVcqPNf5t2wp7nPn/jR3YL6wDEaTSdR7ou0W2k12OWdtcXLpILLauTzrmJCnwHIbU77bUbLKLGfVXQ9gjkgBfyIH4fOpY4joPa64vZAO1DI1RFjVw4tiAukNuw0tLKnKy6mSMm+yJhuTE9rEcXRIAUrXCqplLyRQefM55nSDI=
References: <20210206214734.1577849-1-horatiu.vultur@microchip.com>
 <20210206214734.1577849-3-horatiu.vultur@microchip.com>
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Message-ID: <9fe710dc-79c3-6161-6bfa-917239d4eba9@prevas.dk>
Date: Tue, 9 Feb 2021 08:38:08 +0100
In-Reply-To: <20210206214734.1577849-3-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net 2/2] switchdev: mrp: Remove
 SWITCHDEV_ATTR_ID_MRP_PORT_STAT
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Horatiu Vultur <horatiu.vultur@microchip.com>, jiri@resnulli.us, ivecera@redhat.com, davem@davemloft.net, kuba@kernel.org, roopa@nvidia.com, nikolay@nvidia.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org

On 06/02/2021 22.47, Horatiu Vultur wrote:
> Now that MRP started to use also SWITCHDEV_ATTR_ID_PORT_STP_STATE to
> notify HW, then SWITCHDEV_ATTR_ID_MRP_PORT_STAT is not used anywhere
> else, therefore we can remove it.
> 
> Fixes: c284b545900830 ("switchdev: mrp: Extend switchdev API to offload MRP")
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>

Acked-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>

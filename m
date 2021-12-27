Return-Path: <nikolay@nvidia.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rHjc+haXJ3N0fI3TA9Jur+pxStmTK8+xRk3JKyYpXu4=;
 b=MZDkm1eIe8dDle4fvPlAWj2UJzGWlMQT466hy45/eqkmBOB7SP0JlkvU4VuhtWO+1YI2kaM4vt8dHQ9vB41coASIti+x62krHNln5a2IcKdXh1EDUB9nqOKh6o6kSfGNmXU2TqcX9QYzOxigd8NLmx8rZv9n5zV+RQDex0FrdZE62rnh2v/ybdttwQWdkM2xe3vJ26Sokm6lW1E+lQPyk7hyqQmWiD88KIPKpeQfKpSQBiCSxnfEZSsI0he6dVBuzzSXFv+K0dXobdaSZT5LhaPg1WLH8gnDgpLMDes3zlQI8szoKmoCuWNpngHg7238KAekrgKKt/FXxITtAXdF1g==
Message-ID: <ec0cd540-e785-3a3a-311f-10f0d7bc7adc@nvidia.com>
Date: Mon, 27 Dec 2021 13:55:51 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20211224114640.29679-1-repk@triplefau.lt>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
In-Reply-To: <20211224114640.29679-1-repk@triplefau.lt>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] net: bridge: Get SIOCGIFBR/SIOCSIFBR
 ioctl working in compat mode
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Remi Pommarel <repk@triplefau.lt>, netdev@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>

On 24/12/2021 13:46, Remi Pommarel wrote:
> In compat mode SIOC{G,S}IFBR ioctls were only supporting
> BRCTL_GET_VERSION returning an artificially version to spur userland
> tool to use SIOCDEVPRIVATE instead. But some userland tools ignore that
> and use SIOC{G,S}IFBR unconditionally as seen with busybox's brctl.
> 
> Example of non working 32-bit brctl with CONFIG_COMPAT=y:
> $ brctl show
> brctl: SIOCGIFBR: Invalid argument
> 
> Example of fixed 32-bit brctl with CONFIG_COMPAT=y:
> $ brctl show
> bridge name     bridge id               STP enabled     interfaces
> br0
> 
> Signed-off-by: Remi Pommarel <repk@triplefau.lt>
> Co-developed-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  net/bridge/br_ioctl.c | 75 ++++++++++++++++++++++++++++---------------
>  net/socket.c          | 20 ++----------
>  2 files changed, 52 insertions(+), 43 deletions(-)
> 

Looks good to me, thanks.
Acked-by: Nikolay Aleksandrov <nikolay@nvidia.com>



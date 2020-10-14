Return-Path: <kuba@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1602716445;
 bh=0yFMeVxJSFee7hyJocT4ZeyIzid2yFVT0Ff0q160Phs=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=ABAN+jQI6eY+2CZX08Qe77LK0AYi1r7zx0qpx+ByTBpx0RHsQ1BLv1G6wM8wTWZai
 ULHDEwQ9euZZbap3Mg2fN5DPEElL2H6ME5hmAIzb3M5KIcNiNey9rSjexhkodJIHQO
 6cv9yjqDGrkWy2SVioRuq1VHiG9s99ymIM0OkV0w=
Date: Wed, 14 Oct 2020 16:00:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
Message-ID: <20201014160042.4967a702@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
In-Reply-To: <20201012140428.2549163-5-henrik.bjoernlund@microchip.com>
References: <20201012140428.2549163-1-henrik.bjoernlund@microchip.com>
 <20201012140428.2549163-5-henrik.bjoernlund@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v5 04/10] bridge: cfm: Kernel space
 implementation of CFM. MEP create/delete.
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

On Mon, 12 Oct 2020 14:04:22 +0000 Henrik Bjoernlund wrote:
> with restricted management access to each other<E2><80><99>s equipment.

Some Unicode funk in this line?

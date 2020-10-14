Return-Path: <kuba@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1602716329;
 bh=kMpSZ3gkc8inIapGbTJlpkhoLPPmZniPgrwUXxmM2FU=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=B6VbtQ3tyTewZBxnTOsymsv3qs0RJqXSESXnExKF2QgXdsa3371f/s9Md09zdoZP1
 skefn7C8UTTMAPuZRpo/nshzGKnBY5p0ivy6KSTvO6wDn9Gr3o+aF20KMEVPRie70p
 DZDFnxFz2cyVZiugZWwkbMt7LnmBB4Udpy+4kdyU=
Date: Wed, 14 Oct 2020 15:58:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
Message-ID: <20201014155847.2eb150f5@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
In-Reply-To: <20201012140428.2549163-1-henrik.bjoernlund@microchip.com>
References: <20201012140428.2549163-1-henrik.bjoernlund@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
To: Henrik Bjoernlund <henrik.bjoernlund@microchip.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, idosch@mellanox.com, jiri@mellanox.com, nikolay@nvidia.com, roopa@nvidia.com, Horatiu Vultur <horatiu.vultur@microchip.com>, davem@davemloft.net

On Mon, 12 Oct 2020 14:04:18 +0000 Henrik Bjoernlund wrote:
> Connectivity Fault Management (CFM) is defined in 802.1Q section 12.14.
>=20
> Connectivity Fault Management (CFM) comprises capabilities for detecting,=
 verifying,
> and isolating connectivity failures in Virtual Bridged Networks.
> These capabilities can be used in networks operated by multiple independe=
nt organizations,
> each with restricted management access to each other=E2=80=99s equipment.

Please wrap the cover letter and commit messages to 70 chars.

> Reviewed-by: Horatiu Vultur  <horatiu.vultur@microchip.com>
> Signed-off-by: Henrik Bjoernlund  <henrik.bjoernlund@microchip.com>

You have two spaces after the name in many tags.

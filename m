Return-Path: <kuba@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1604026685;
 bh=bn3PwUQZ4HURowa7zUAdB3s9KM7KO4YoVStGZI5euac=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=tkx+Xas6CA/B6c7y7VPcYq0AsN9C19JIdifc4LzYM3Y6DaEPjvAZRqZzb8g0s7Li5
 P0x79d8V1qzWeqV+WoqmiGQjuIi0IKMA67NVa9f/wBEuOvfc9m31ZRlQAKqxpxSTyQ
 uBPOT4HwwnNHEb/+jsWmRBEIwusl7Hpi3Ieys0RI=
Date: Thu, 29 Oct 2020 19:58:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
Message-ID: <20201029195804.0fbbf0c1@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
In-Reply-To: <20201027100251.3241719-1-henrik.bjoernlund@microchip.com>
References: <20201027100251.3241719-1-henrik.bjoernlund@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH net-next v7 00/10] net: bridge: cfm: Add
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

On Tue, 27 Oct 2020 10:02:41 +0000 Henrik Bjoernlund wrote:
> Connectivity Fault Management (CFM) is defined in 802.1Q
> section 12.14.
>=20
> Connectivity Fault Management (CFM) comprises capabilities for
> detecting, verifying, and isolating connectivity failures in Virtual
> Bridged Networks. These capabilities can be used in networks
> operated by multiple independent organizations, each with restricted
> management access to each other=E2=80=99s equipment.

Applied, thanks!

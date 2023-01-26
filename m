Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6D37A82446
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 308DB82425
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=p6e1idkozAdyFbwzDMBHWW8sAO0btgqXBL7hMwd+oBo=;
 b=rvmm5Mwlqg15HnFqmljC0zk3wG+Tmm/MAtPRw7Z7iIY2XJM4sSAfDUGWgJ2Iz5WMUL
 aT28kc0M17ns4kNIhpn+o/UBxWC+4/Y2dE1AgaCXCnTHgjXlUnVo2s9sP1GyLHcPc+GT
 2oZCZauWaTCoKLnZrbtb2FzA6J5rANzAab0EEFBEa0mS9tqBLzPhZERUfgi8ucIVpGMd
 zjFIT7SH6+BC8FPZIu+6yjc/QTO6sG//ik+hwfWrP3tLXNwoFS7a6FM8S33knZAZs3na
 7iBG3KLKS3Oi/tlDacEcr0HKdEBE6Bfh1cIJcwfBYu9PolKJN2SiTuVSJpjvfwarCx5Y
 /QYQ==
Date: Thu, 26 Jan 2023 22:27:49 +0200
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20230126111843.2544f7d1@hermes.local>
References: <cover.1674752051.git.petrm@nvidia.com>
 <8886e11bde5874305a26c0b7dc397923a1d5a794.1674752051.git.petrm@nvidia.com>
 <20230126111843.2544f7d1@hermes.local>
Message-ID: <A066ECE0-C02B-426E-9591-670CC234299A@blackwall.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH net-next 01/16] net: bridge: Set
	strict_start_type at two policies
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <stephen@networkplumber.org>, Petr Machata <petrm@nvidia.com>
Cc: netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>

On January 26, 2023 9:18:43 PM GMT+02:00, Stephen Hemminger <stephen@networ=
kplumber=2Eorg> wrote:
>On Thu, 26 Jan 2023 18:01:09 +0100
>Petr Machata <petrm@nvidia=2Ecom> wrote:
>
>>  static const struct nla_policy br_port_policy[IFLA_BRPORT_MAX + 1] =3D=
 {
>> +	[IFLA_BRPORT_UNSPEC]	=3D { =2Estrict_start_type =3D
>> +					IFLA_BRPORT_MCAST_EHT_HOSTS_LIMIT + 1 },
>
>Is the original IFLA_BRPORT a typo? ETH not EHT


No, it's not a typo, Explicit Host Tracking

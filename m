Return-Path: <seladona@icloud.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 584C941B5B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 99D4341B3A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
 s=1a1hai; t=1666180739;
 bh=Hbw27RqrnkmZsouexnsyZjMFcBnI4MG8WYB6dVJNrA8=;
 h=Content-Type:From:Mime-Version:Subject:Message-Id:Date:To;
 b=NheKbgSZ/D6A4KTHxD5eQ8Uo4Yqx7MwiwkFvKP9R4bOe1VK/EgAKNKxjf0R0Z39Id
 mCj9xi8hsw3Q24iqfFpslb+ckmrX8b37ECj/XPz7G75uEQEkq++qbdMKk4mOsPF6Ix
 WCIhMTG4OO3E7thVlYetT7++q/MIRa+RWQD81b20xYC226BSogeUKlN+5KaQeHGNIz
 bGJEg0pFHd/D25b5E2m0VlFE4/RPLlTZktO6p3SN3Yo9PZW1K5/K+FeKhuCQgVE0Fz
 DzRTNx5THrJ1Y71J3VrnFD5pYk70Qq+66z+Doi9foW90P8pdNO6dRxO+otldEi2Izf
 o8ZQwM0Ifp/TA==
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Sela Dona <seladona@icloud.com>
Mime-Version: 1.0 (1.0)
Message-Id: <FC11D4BD-CB53-4417-9E16-799C2777F573@icloud.com>
Date: Wed, 19 Oct 2022 07:58:57 -0400
Subject: Re: [Bridge] [PATCH 106/141] net: bridge: Fix fall-through warnings
	for Clang
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

=EF=BB=BF

Sent from my iPhone=

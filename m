Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFD937160
	for <bridge@lists.linux.dev>; Mon, 11 Nov 2024 04:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731299967; cv=none; b=PWvxSDU7oyYK0hj5PsR44JDreeXSHL4+vir54D/dwloayryOFRQhfBJCRgPYo+oxRAdd9TmyJu1OtmOK3WRZFfKS4RYvrp0OvBUpmZ/SbIqlS1qDwdwyRiKmPwp2AIyJQUWeSD+S7h9Xboe0UVAIzjfQhgl7wySbUfwCRuOi3vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731299967; c=relaxed/simple;
	bh=W8lMUupaMdWObhzeagnCd+rqivWgp6XoH2HFEMVHlXk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XwXE00ey71H0/+ptLTcShIBa8RyInzPvbGtyts7Su7K5ibLnYV0XjqGOO9S7r9VBhfbbL+JZLVNEx2RoIcYo7Nm0JqY+0vhXodw7etTva2E76vBuzuLIjxqWHQxCawjQ6fsA4iUBQN3IBxkpsZigColc8eybKcf62ip6JPOY08M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=SgdetogM; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="SgdetogM"
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 1024D2C01EE;
	Mon, 11 Nov 2024 17:39:21 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1731299961;
	bh=W8lMUupaMdWObhzeagnCd+rqivWgp6XoH2HFEMVHlXk=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=SgdetogMEIKiZ8WDW4KuNJiF9P1uZFDr9Upzz+lsDeVaR0iV8qrnbBKNMuXloo5ac
	 IJXFmFgQRSRJ31+BELLoezR+WNxWp54yjinbNn4c3LSBsDVNTMo0JZ8gaj3wft99Bf
	 bPuog/1RKYROcb4vf75+9bNDjszfW3tKlGm/8Td4A0DscKhE8o9Uma8z8zcqn3eLVy
	 vpFAnRZ20vd6jWFuDBl+YwNmfA7vyJiY0ZVZLRSFJT6BiUnJkRf2LZWYz8wivh/2tz
	 ZLlpKKa3PYIbGS6VH+vNk6MWgHa4ychpebrHL0T83l1AbLrzTNlUDEEkxzWpaGk/mN
	 GeJlatJUjcQ5Q==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B67318a780000>; Mon, 11 Nov 2024 17:39:20 +1300
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 11 Nov 2024 17:39:20 +1300
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1544.011; Mon, 11 Nov 2024 17:39:20 +1300
From: Elliot Ayrey <Elliot.Ayrey@alliedtelesis.co.nz>
To: "andrew@lunn.ch" <andrew@lunn.ch>
CC: "razor@blackwall.org" <razor@blackwall.org>, "olteanv@gmail.com"
	<olteanv@gmail.com>, "bridge@lists.linux.dev" <bridge@lists.linux.dev>,
	"davem@davemloft.net" <davem@davemloft.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
	"roopa@nvidia.com" <roopa@nvidia.com>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "kuba@kernel.org" <kuba@kernel.org>
Subject: Re: [RFC net-next (resend) 3/4] net: dsa: mv88e6xxx: handle
 member-violations
Thread-Topic: [RFC net-next (resend) 3/4] net: dsa: mv88e6xxx: handle
 member-violations
Thread-Index: AQHbMZIaQ3J67Iwom067VLvbmY9w5bKsjSAAgAQdJgA=
Date: Mon, 11 Nov 2024 04:39:20 +0000
Message-ID: <9026b4a60c2782b5d50fd26f07a12d7cd5e23015.camel@alliedtelesis.co.nz>
References: <20241108035546.2055996-1-elliot.ayrey@alliedtelesis.co.nz>
	 <20241108035546.2055996-4-elliot.ayrey@alliedtelesis.co.nz>
	 <e9829b58-664a-4bd1-bc07-5f80915a3eed@lunn.ch>
In-Reply-To: <e9829b58-664a-4bd1-bc07-5f80915a3eed@lunn.ch>
Accept-Language: en-US, en-NZ
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <D9428D0726E8C74291D0917B807C5FB5@atlnz.lc>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=ca1xrWDM c=1 sm=1 tr=0 ts=67318a78 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=nyesw9g_oEEA:10 a=IkcTkHD0fZMA:10 a=VlfZXiiP6vEA:10 a=62ntRvTiAAAA:8 a=8i6-b8GgAAAA:8 a=_Z8lNTzjtIKWTrsjzlEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=pToNdpNmrtiFLRE6bQ9Z:22 a=XAGLwFu5sp1jj7jejlXE:22
X-SEG-SpamProfiler-Score: 0

T24gRnJpLCAyMDI0LTExLTA4IGF0IDE0OjQ5ICswMTAwLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
PiAtLS0gYS9kcml2ZXJzL25ldC9kc2EvbXY4OGU2eHh4L3N3aXRjaGRldi5jDQo+ID4gKysrIGIv
ZHJpdmVycy9uZXQvZHNhL212ODhlNnh4eC9zd2l0Y2hkZXYuYw0KPiA+IEBAIC03OSw1ICs3OSwz
NiBAQCBpbnQgbXY4OGU2eHh4X2hhbmRsZV9taXNzX3Zpb2xhdGlvbihzdHJ1Y3QNCj4gPiBtdjg4
ZTZ4eHhfY2hpcCAqY2hpcCwgaW50IHBvcnQsDQo+ID4gwqAJCQkJICAgICAgIGJycG9ydCwNCj4g
PiAmaHR0cDovL3NjYW5tYWlsLnRydXN0d2F2ZS5jb20vP2M9MjA5ODgmZD1qWmV1NTI4cXNkZlZt
SUNIZGtaQW91ZW9nDQo+ID4gV0xFd3NOX1dhX1JJTGxhMFEmdT1odHRwJTNhJTJmJTJmaW5mbyUy
ZWluZm8gTlVMTCk7DQo+ID4gwqAJcnRubF91bmxvY2soKTsNCj4gPiDCoA0KPiA+IC0JcmV0dXJu
IGVycjsNCj4gPiArCXJldHVybiBub3RpZmllcl90b19lcnJubyhlcnIpOw0KPiA+ICt9DQo+IA0K
PiBUaGlzIGNoYW5nZSBkb2VzIG5vdCBsb29rIG9idmlvdXNseSBjb3JyZWN0IHRvIG1lLiBXaGF0
IGhhcyBhIG1pc3MNCj4gdmlvbGF0aW9uIGdvdCB0byBkbyB3aXRoIG1lbWJlciB2aW9sYXRpb24/
IElzIHRoZSBleGlzdGluZyBjb2RlDQo+IHdyb25nPw0KPiBXaGF0IGFib3V0IHRoZSBjYXNlIHdo
ZW4gbXY4OGU2eHh4X2ZpbmRfdmlkKCkgcmV0dXJucyBhbiBlcnJvcj8NCj4gDQo+IAlBbmRyZXcN
Cg0KSGkgQW5kcmV3LCBJIGZvcmdvdCB0byByZW1vdmUgdGhpcyB3aGVuIHByZXBhcmluZyB0aGUg
cGF0Y2hlcywgdGhpcyB3YXMNCmludGVuZGVkIHRvIGJlIGEgc2VwYXJhdGUgYnVnIGZpeC4NCg0K
SWYgbXY4OGU2eHh4X2ZpbmRfdmlkKCkgcmV0dXJucyBhbiBlcnJvciBpdCB3aWxsIHJldHVybiBl
YXJseSwgc28gdGhlDQpub3RpZmllcl90b19lcnJubygpIGNvbnZlcnNpb24gd2lsbCBvbmx5IGhh
cHBlbiBhZnRlcg0KY2FsbF9zd2l0Y2hkZXZfbm90aWZpZXJzKCkuDQo=

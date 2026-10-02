Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0BE38D3F2;
	Fri,  2 Oct 2026 20:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790972330; cv=none; b=mwsGCbP0Me0/GmlLc8n4U+wgDP2sTR8dQ/wUMyB4WKJ5of0UdFWHoxFXUxx7KcvhHilNWL8hOBgqB6vrMI9xdVi3Crn4MUUqLAipFXZaPCKWmlrmbRSjzVScj4MDx2efy5FbQ2nphBN0xwlUdNgxfanlN9AFGR3X6Kr/RCRPHZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790972330; c=relaxed/simple;
	bh=njn1mQ6jU3MZKA7N/04u3TMi/Nwgk5hNF0AsmbcWUgk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AiglgsAlkXhUMZtlMBBT6P2014W3ZtNmutpfYzTmjnx362tzBHFQUfxy4NQy4ob+ybSqNXmcbo3Pk1Pl2nsFMHhIRNJY2nHgRg7oB6G3o6Be23qGIOLf6Y8xrbnWp/IR8m15wq2yWjHB5fMNtQVGmYwbrmy3g98TCTs6FHOZ25k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mAPjSwmF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mAPjSwmF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 373191F000FF;
	Fri,  2 Oct 2026 20:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790972329;
	bh=njn1mQ6jU3MZKA7N/04u3TMi/Nwgk5hNF0AsmbcWUgk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mAPjSwmFrXnPxY8W3+nSX+dGH08vTWKA+aebDyv9t8zjI4Oya+EpeX2QzZhzk/yUf
	 z2b7oLSD2DVXgaefn4j0KhbSGTTu9TtVNQTtaL2a9ROp5A0pcyc7OVS/gei91Ed+Bt
	 W6y/ej8+6XR18xuKdHz5awmMWFi5ZaFsTSafBBi/VHdUKAtGs8gMzCCK+gtdW8kGfn
	 Wnvem6qx8Lc8INpBERqQBxvwJzXLCxlf79LfrCa/gPppyJZHkW8J83cuhtmpivPrHm
	 85miY6y1HbIXF4m70vOftbASFZ6cLXImE6AR4sO20kgvdU/4thvdiR8ym3mHdP4slS
	 qnDScTVkG7W8Q==
Date: Fri, 2 Oct 2026 13:18:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 bridge@lists.linux.dev
Subject: Re: [PATCH net-next 01/12] net: bridge: introduce a bridge
 destination type
Message-ID: <20261002131848.59bf5a96@kernel.org>
In-Reply-To: <b41da7fb-0ef6-46c0-a174-cd7a7c4448ca@blackwall.org>
References: <20260930071411.2786201-1-razor@blackwall.org>
	<20260930071411.2786201-2-razor@blackwall.org>
	<20261002124531.49e3eaa3@kernel.org>
	<b41da7fb-0ef6-46c0-a174-cd7a7c4448ca@blackwall.org>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 2 Oct 2026 23:09:56 +0300 Nikolay Aleksandrov wrote:
> On 02/10/2026 22:45, Jakub Kicinski wrote:
> > On Wed, 30 Sep 2026 10:14:00 +0300 Nikolay Aleksandrov wrote: =20
> >> Add an opaque destination type and helpers for representing bridge port
> >> destinations. Using a separate structure makes raw pointer assignments=
 and
> >> comparisons fail at build time while marking its value member __private
> >> makes sparse warn about accesses that bypass the helpers. =20
> >=20
> > First time I'm seeing the __private thing. FTR feels quite foreign to C.
> > __bitwise works very nicely for the same thing =F0=9F=A4=B7=EF=B8=8F =20
>=20
> I don't mind switching to __bitwise, no preference here. I saw __private =
initially
> in the console code. It seems to be more restrictive (__bitwise allows di=
rect member
> copies and comparisons, __private warns about those), but if __bitwise is=
 preferred
> I can send a follow-up.

It's alright, mostly flagging for future reference.
And I was curious how you chose it.

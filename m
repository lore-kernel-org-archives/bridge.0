Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DA11CD2B
	for <bridge@lists.linux.dev>; Fri,  5 Apr 2024 11:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712315272; cv=none; b=gnXhccW+KZi0SRCUKqAxZ/20B3Kr0/ow8ypA8FRZj4aNyx7Dht2pVvPsQa+fdjJHrwf5zWwvU7mSaN5Jb7438b9qmoWwlEpFU0Z7x5wrjLaM6dOpU8a+Jdt1Pg+Jd3MyT+p5eB/z/U95FrKXlbaEXpvZWXHYwxxUHMPtgqCtwnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712315272; c=relaxed/simple;
	bh=87fmuLbik3W4Ac3ZqTmrh4k5PYq0/NphQip5MWUxITw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PgazBHl7MqLli3As6Tj9NyW0bK+/npeYfxenoD52ZK2VEnqdWNMFo3KvMQ81B/ujjc2nnJYjDmllNbEZYPFhIdAMrAXMNVb5EYgbO0I+LtKxiAj78QpcalPtU3+aZrvLUTP5l126fO/eAHJfDzv2K1OVh6ckDLmO1HL64niPNZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cOXQsobR; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cOXQsobR"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56e1bbdb362so2519618a12.1
        for <bridge@lists.linux.dev>; Fri, 05 Apr 2024 04:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712315269; x=1712920069; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C9xHgLw53zJpmruDx7tv4qUMo9+hzZpsIUuIr1l11KM=;
        b=cOXQsobR+WStubptg9TnnzcitNiLN5NTwL2i957RgBZEtpw5z5Y0i/j3VeO20FpI4T
         YVCnWAPp+W25o2yMC04xaGvj9KXINLXLBEy/G27xWY/rRNowcftp9DtNptjZaCVgRhEl
         GIxI96IniG/3Q8D6MZ7z3hqV3bsI1oJRXzG+9bzNAXGTqnP4MlojyGY9orO/AXXfyNbV
         8tgS/maz37t9ioELHFZUvv3Vx9KAbb+OUuJWgYGTNLdipE3gfNVERtERaSWtGMgB5ck+
         IhhXnYJc7X2XWbVdHVhtoQ9bBN+V80AAaqL+CnZwoRYuUXxRu2vejEiiFo9uEZprKgDr
         zW/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712315269; x=1712920069;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C9xHgLw53zJpmruDx7tv4qUMo9+hzZpsIUuIr1l11KM=;
        b=IhshyOzAmKD4qobV8cycaQCySDKhKNWS5OLFMSC7c+K61dVoQVCXoyxKMCxpYK3AkW
         eXcDrOfBde8p7VP0BP4XnPK8SfH9mJQRGuLifYE7GFzDmObJVf7dG73V3DUVipLlznQT
         8GzRAXSIuRIWa6g566IQfooY8if4xuOvHaHNou9bZUqFJiNKoRwDq00scHrfta82dZrT
         rGvK9CJpXVHmYXqgFf2zuBvk7SR2r1Xlrsd6MS+BeuRelUocOLwbfphdUjvy1yvbTMY7
         Id2tjUROkxly3SHJ39rMGJ4xbHmyZWufiHaVN8A0vf8sU2tSX4mENR1L4oITcL5MmVnt
         lMvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXa/J+zt9ipURJug078PFT/0pNwlIf/533KChRBGYh8LiITHYdbWSx83nCxCnNDkNfrrTp6wgAekr8Gm3FBJ84nSPV92LuR
X-Gm-Message-State: AOJu0YwX9QOV6OzDN6Ay6rh4NFX23mxBi13WAzVgJlVxh8OxgsUlhD6A
	ioUwYdOrrUMsCeCcL1LDLe0de7gmMKglhs9LiwDHX1k3xQRXKyTQ
X-Google-Smtp-Source: AGHT+IGG1+9Mqc13eWk/3SacISlrxycbkz+FTzpktzUPXrv/hdfTUb1d5xcoorCxuKaN2KMIYlqb4Q==
X-Received: by 2002:a50:9316:0:b0:56c:4db:33f7 with SMTP id m22-20020a509316000000b0056c04db33f7mr829730eda.10.1712315269128;
        Fri, 05 Apr 2024 04:07:49 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d700:2000::b2c])
        by smtp.gmail.com with ESMTPSA id p15-20020a05640243cf00b0056c2d0052c0sm666532edc.60.2024.04.05.04.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 04:07:48 -0700 (PDT)
Date: Fri, 5 Apr 2024 14:07:45 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Joseph Huang <joseph.huang.2024@gmail.com>
Cc: Joseph Huang <Joseph.Huang@garmin.com>, netdev@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>,
	linux-kernel@vger.kernel.org, bridge@lists.linux.dev
Subject: Re: [PATCH RFC net-next 07/10] net: dsa: mv88e6xxx: Track bridge mdb
 objects
Message-ID: <20240405110745.si4gc567jt5gwpbr@skbuf>
References: <20240402001137.2980589-1-Joseph.Huang@garmin.com>
 <20240402001137.2980589-8-Joseph.Huang@garmin.com>
 <20240402122343.a7o5narxsctrkaoo@skbuf>
 <b5f79571-b4a8-4f21-8dc8-e1aa11056a5d@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5f79571-b4a8-4f21-8dc8-e1aa11056a5d@gmail.com>

On Thu, Apr 04, 2024 at 04:43:38PM -0400, Joseph Huang wrote:
> Hi Vladimir,
> 
> On 4/2/2024 8:23 AM, Vladimir Oltean wrote:
> > Can you comment on the feasibility/infeasibility of Tobias' proposal of:
> > "The bridge could just provide some MDB iterator to save us from having
> > to cache all the configured groups."?
> > https://lore.kernel.org/netdev/87sg31n04a.fsf@waldekranz.com/
> > 
> > What is done here will have to be scaled to many drivers - potentially
> > all existing DSA ones, as far as I'm aware.
> > 
> 
> I thought about implementing an MDB iterator as suggested by Tobias, but I'm
> a bit concerned about the coherence of these MDB objects. In theory, when
> the device driver is trying to act on an event, the source of the trigger
> may have changed its state in the bridge already.

Yes, this is the result of SWITCHDEV_F_DEFER, used by both
SWITCHDEV_ATTR_ID_PORT_MROUTER and SWITCHDEV_OBJ_ID_PORT_MDB.

> If, upon receiving an event in the device driver, we iterate over what
> the bridge has at that instant, the differences between the worlds as
> seen by the bridge and the device driver might lead to some unexpected
> results.

Translated: iterating over bridge MDB objects needs to be serialized
with new switchdev events by acquiring rtnl_lock(). Then, once switchdev
events are temporarily blocked, the pending ones need to be flushed
using switchdev_deferred_process(), so resync the bridge state with the
driver state. Once the resync is done, the iteration is safe until
rtnl_unlock().

Applied to our case, the MDB iterator is needed in mv88e6xxx_port_mrouter().
This is already called with rtnl_lock() acquired. The resync procedure
will indirectly call mv88e6xxx_port_mdb_add()/mv88e6xxx_port_mdb_del()
through switchdev_deferred_process(), and then the walk is consistent
for the remainder of the mv88e6xxx_port_mrouter() function.

A helper which does this is what would be required - an iterator
function which calls an int (*cb)(struct net_device *brport, const struct switchdev_obj_port_mdb *mdb)
for each MDB entry. The DSA core could then offer some post-processing
services over this API, to recover the struct dsa_port associated with
the bridge port (in the LAG case they aren't the same) and the address
database associated with the bridge.

Do you think there would be unexpected results even if we did this?
br_switchdev_mdb_replay() needs to handle a similarly complicated
situation of synchronizing with deferred MDB events.

> However, if we cache the MDB objects in the device driver, at least
> the order in which the events took place will be coherent and at any
> give time the state of the MDB objects in the device driver can be
> guaranteed to be sane. This is also the approach the prestera device
> driver took.

Not contesting this, but I wouldn't like to see MDBs cached in each
device driver just for this. Switchdev is not very high on the list of
APIs which are easy to use, and making MDB caching a requirement
(for the common case that MDB entry destinations need software fixups
with the mrouter ports) isn't exactly going to make that any better.
Others' opinion may differ, but mine is that core offload APIs need to
consider what hardware is available in the real world, make the common
case easy, and the advanced cases possible. Rather than make every case
"advanced" :)

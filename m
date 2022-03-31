Return-Path: <primalgamer@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=ih8LLR4BU+XOLlBsaeGuInD35g84knZ55fEb+sWwQLE=;
 b=m9JY1T2fVJqS1fYJnX1Lbbcho5BEeSvJ1p2iErBWUKphqwHPfoBqWO2JuqjqBkcoOr
 PhdBsvQEtQEksesBExzSODztEFHY/06NnfOTXsWOfhxz1AsijLl24rnJolO3zP5IEjcG
 1b6OVr/lWoGBdZGFaaaINISsCVnsolB5EZKdx4uQu2c9d7ISDsrjHq2VXcNh6jKwLeEj
 jngwNN7AW3Y5Fa/i83q9RtjecmjAuN3Ja1WgzWShQ9+B4QH5r+JcnGLP2U5FLSV2KP24
 auOI9ZL7exC5GSjNDcE49mf4SvlXh7ntbfVGGExwFPdmfCSu9h172QOxxDymZ4F8M3MN
 i8ZA==
MIME-Version: 1.0
From: SPYFF <primalgamer@gmail.com>
Date: Thu, 31 Mar 2022 11:17:13 +0200
Message-ID: <CAAej5NbAYjLSTBhS5Xcv+zztdhECoZWYr1Kxnyut=NSVQJ+VOg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Bridge] [bridge]: STP: no port in blocking state despite a
 loop when in a network namespace
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bugs.a.b@free.fr
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, nikolay@nvidia.com, roopa@nvidia.com

Hi!

Can confirm this is still the case on 5.15 too.

Ferenc

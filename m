Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Jun 2008 13:10:53 +0200
Message-ID: <E88155B5BD67CE4D87A3F1F70950B96A2FF8AE@berta.maurer-it.com>
In-Reply-To: <4850FA96.1050205@trash.net>
References: <E88155B5BD67CE4D87A3F1F70950B96A2FF8A8@berta.maurer-it.com>	<20080611085859.721e3917@extreme>
	<E88155B5BD67CE4D87A3F1F70950B96A2FF8AA@berta.maurer-it.com>
	<4850FA96.1050205@trash.net>
From: "Dietmar Maurer" <dietmar@proxmox.com>
Subject: Re: [Bridge] Bridge MAC selection
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

>>> There any side effects with the following patch?
>> Not for you. But if it got changed now, it would surprise the=20
>> existing users (change in ABI behaviour).=20

If there are no other side effects, I wonder whats better:

A.) unexpected Network failures due to mac changes

B.) surprised users (does anybody depend on such behavour?)

I vote for A.)

- Dietmar


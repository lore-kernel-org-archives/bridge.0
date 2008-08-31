Date: Sun, 31 Aug 2008 23:02:47 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-ID: <20080831230247.76b5a193@lxorguk.ukuu.org.uk>
In-Reply-To: <20080831104309.780cc01f@extreme>
References: <fa.wTMiBcGRgw2fBtdHwtX7y0lkc8s@ifi.uio.no>
	<48975BD3.6040709@shaw.ca>
	<a08621850808041337k1d1deb6fk78098d9fcd4930dd@mail.gmail.com>
	<20080807185802.GA16327@electric-eye.fr.zoreil.com>
	<a08621850808101200n220afd2dve58abe67830b7a4f@mail.gmail.com>
	<a08621850808110053j5cbf23e6xdf52c9e7440abf19@mail.gmail.com>
	<a08621850808291848q5660148fx57d576ecfcbfce8@mail.gmail.com>
	<a08621850808310151o143845h195a8658d02270d9@mail.gmail.com>
	<20080831100537.6929c51e@extreme> <20080831104309.780cc01f@extreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [RFC] bridge: STP timer management range checking
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@vyatta.com>
Cc: Robert Hancock <hancockr@shaw.ca>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Francois Romieu <romieu@fr.zoreil.com>, Dushan Tcholich <dusanc@gmail.com>, David Miller <davem@davemloft.net>

On Sun, 31 Aug 2008 10:43:09 -0700
Stephen Hemminger <shemminger@vyatta.com> wrote:

> The Spanning Tree Protocol timers need to be set within certain boundaries
> to keep the internal protocol engine working, and to be interoperable.
> This patch restricts changes to those timers to the values defined in IEEE 802.1D
> specification.

Why do we care ? You have to be the network administrator to set values,
there are cases you may want to be out of the spec and you are
privileged. The kernel does need to stop things being done which are
fatal but running around restricting privileged administrators who have
the ability to bring the network down anyway isn't its job.

Seems bogus extra code to me - stops things working that should be
allowed too.

Date: Fri, 10 Jun 2005 13:14:57 -0700
From: Ted Deppner <ted@psyber.com>
Subject: Re: [Bridge] Multicast
Message-ID: <20050610201457.GA12387@nambi>
References: <20050608093152.32e3c9c5@unknown-215.office.pdx.osdl.net>
	<043301c56cd0$18151780$825810ac@amon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <043301c56cd0$18151780$825810ac@amon>
Reply-To: Ted Deppner <ted@psyber.com>
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Tomo Ceferin <tomo@activetools.si>
Cc: bridge@lists.osdl.org

On Thu, Jun 09, 2005 at 10:48:36AM +0200, Tomo Ceferin wrote:
> Did anyone already have to deal with this? If not, I think it's time bridge
> got a proper multicast implementation as well.

I've dealt with this in the context of a locally generated multicast
source being sent out a bridge interface to two physical ethernet
interfaces.  This was a video stream and ran at various bit rates from
3.5mb up to 20mbit (as single streams).

Everything worked properly until the MTU was raised past 1500 bytes.  Once
the traffic had to be fragmented, then the bridge stopped sending the
packets out both physicial interfaces, and would only send out the first
physical interface that was added to the bridge.

-- 
Ted Deppner
http://www.deppner.us/

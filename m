References: <87pszl99je.fsf@aka.i.naked.iki.fi>
	<20050131172541.GL19777@sampo2.csc.fi>
From: Nuutti Kotivuori <naked@iki.fi>
Date: Mon, 31 Jan 2005 20:17:10 +0200
In-Reply-To: <20050131172541.GL19777@sampo2.csc.fi> (Ville Mattila's message
	of "Mon, 31 Jan 2005 19:25:41 +0200")
Message-ID: <877jlt8nvd.fsf@aka.i.naked.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bridge] Re: Bridge MAC address
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Ville Mattila <Ville.Mattila@csc.fi>
Cc: bridge@osdl.org

Ville Mattila wrote:
> On Mon, 31 Jan 2005, Nuutti Kotivuori wrote:
>
>> How can I set the MAC address for a bridge? The MAC address given
>> for
>
> How about changing all the physical interfaces to use the same MAC
> address before

[...]

Well, the issue is more complicated than that, since the bridges are
set up dynamically and interfaces are removed and added on the fly -
and many bridges might not even have a single physical interface, only
TAP devices as members.

-- Naked


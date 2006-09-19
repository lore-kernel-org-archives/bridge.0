Date: Tue, 19 Sep 2006 10:27:35 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Message-ID: <20060919102735.789ea14a@localhost.localdomain>
In-Reply-To: <20060915141905.18847.qmail@web37010.mail.mud.yahoo.com>
References: <20060915141905.18847.qmail@web37010.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Linux bridge and virtual interfaces
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Ken Peirce <thewirelessmacdude@yahoo.com>
Cc: bridge@osdl.org

On Fri, 15 Sep 2006 07:19:05 -0700 (PDT)
Ken Peirce <thewirelessmacdude@yahoo.com> wrote:

> Do STP BPDUs get delivered to all interfaces, including virtual interfaces?
>   Cheers,
>   Ken Peirce
>    

Any interface that is part of bridge will get STP BPDU's sent on it.
If you want to receive STP BPDU's you need to be using latest kernel and
use LLC. Normally STP BPDU's were just absorbed by the bridge code.

-- 
Stephen Hemminger <shemminger@osdl.org>

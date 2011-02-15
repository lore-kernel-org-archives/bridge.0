Date: Tue, 15 Feb 2011 08:03:34 -0800
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20110215080334.1fbc5357@nehalam>
In-Reply-To: <OF0ED85024.3389DB4D-ON8525782D.0054FDD2-8525782D.00597D7B@us.ibm.com>
References: <OF0ED85024.3389DB4D-ON8525782D.0054FDD2-8525782D.00597D7B@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Problem configuring bridge as a hub between host
 server and running VM guest
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ravi Varun Nair <rvnair@us.ibm.com>
Cc: bridge@lists.linux-foundation.org

On Fri, 4 Feb 2011 11:17:29 -0500
Ravi Varun Nair <rvnair@us.ibm.com> wrote:

> What I am trying to do is have a copy of all the traffic coming in on the 
> physical interface be given to the VM. T

A better way is to use tc mirred action to mirror packets to a dummy or other
interface.

-- 

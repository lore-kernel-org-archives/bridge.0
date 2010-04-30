Date: Fri, 30 Apr 2010 08:47:21 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20100430084721.5db539b1@nehalam>
In-Reply-To: <F2E37429BA50E34EA0B7F97AFEB8CBD11018288F@mercure.tus.fr.thales>
References: <F2E37429BA50E34EA0B7F97AFEB8CBD11018288F@mercure.tus.fr.thales>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Bridging Features : snmp
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Boulay Gilles <Gilles.Boulay@fr.thalesgroup.com>
Cc: "'bridge@osdl.org'" <bridge@linux-foundation.org>

On Fri, 30 Apr 2010 14:49:22 +0200
Boulay Gilles <Gilles.Boulay@fr.thalesgroup.com> wrote:

> Bonjour,
> 
> We are experiencing the bridge feature. We would like to evaluate snmp
> protocol on it.
> Could it be able to use this feature ? If Yes , could you provide us some
> informations ?
> Thanks a lot
> Regards
> G.Boulay
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge

Checkout net-snmp project.  Support of SNMP is really a user space
issue, not kernel. I don't think the current net-snmp has the bridge mib

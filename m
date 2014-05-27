Return-Path: <pneira@us.es>
Date: Tue, 27 May 2014 10:33:59 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
Message-ID: <20140527083359.GA4342@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Bridge] [HEADS UP] Migrating ebtables and arptables to
	netfilter.org
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netfilter-devel@vger.kernel.org
Cc: bridge@lists.linux-foundation.org, netfilter@vger.kernel.org, Bart De Schuymer <bdschuym@pandora.be>

Hi!

We're migrating arptables and ebtables to git.netfilter.org. The new
location for the repositories are:

1) arptables:

        git://git.netfilter.org/arptables
        http://git.netfilter.org/arptables/

2) ebtables:

        git://git.netfilter.org/ebtables
        http://git.netfilter.org/ebtables/

Originally, these two applications were located in the same repository
which has been kept at:

        http://git.netfilter.org/ebtables.old-history/

just for the record.

I have git-filter-branch the original repository to separate the
ebtables and the arptables in two independent repositories.

Let me know if you experience any problem in this migration,
Thanks.

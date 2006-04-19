Date: Wed, 19 Apr 2006 14:16:06 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] help adding RSTP (802.1w) support
Message-ID: <20060419141606.3e680251@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.64.0604191347290.8661@yukonho.teaktechnologies.com>
References: <Pine.LNX.4.64.0604191347290.8661@yukonho.teaktechnologies.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Edward K Chien <edchien@teaktechnologies.com>
Cc: bridge@osdl.org

On Wed, 19 Apr 2006 14:06:45 -0700 (PDT)
Edward K Chien <edchien@teaktechnologies.com> wrote:

> 
> I am interested in finding out about the current efforts in adding RSTP 
> (802.1w) support to the current bridging module (more interested in 2.6 
> tree).  I am a developer and can offer my help in either developing the 
> code, porting over work from a 2.4 tree, or in a testing capacity.
> 
> I would appreciate it if people who are working on this can contact me and 
> let me know the status of the efforts.  I'd hate to have to write it from 
> scratch, only to throw it away a year later.  Thanks. :-)
> 
> eddie

I am working on adding a netlink interface to communicate all necessary
state information to user space. Then plan to rework rstplib or something
similar.

Date: Tue, 14 Apr 2009 08:08:00 -0700
From: Stephen Hemminger <shemminger@vyatta.com>
Message-ID: <20090414080800.178d636a@nehalam>
In-Reply-To: <E9E3926FA9CDBF489EA1684042C8A026012DBC6B@zmy16exm72.ds.mot.com>
References: <E9E3926FA9CDBF489EA1684042C8A026012DBAA9@zmy16exm72.ds.mot.com>
	<20090413080009.034a5e7f@nehalam>
	<E9E3926FA9CDBF489EA1684042C8A026012DBC38@zmy16exm72.ds.mot.com>
	<20090413230431.50d58d61@nehalam>
	<E9E3926FA9CDBF489EA1684042C8A026012DBC6B@zmy16exm72.ds.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Out of memory problem
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Tekale Sharad-FHJN78 <FHJN78@motorola.com>
Cc: bridge@lists.linux-foundation.org

On Tue, 14 Apr 2009 14:10:01 +0800
"Tekale Sharad-FHJN78" <FHJN78@motorola.com> wrote:

> > What network device driver, that is probably the problem?
> We are using Openwrt on our AP, and the driver is mvswitch.c its an
> marvell driver.
> 
> If possible, can you point me to some piece of code in the driver to
> check for memory leak?
> 
> Thanks Again,
> Sharad.

If the driver was open source and in one of the standard distributions,
it could be reviewed. But since you are on an older kernel with a non-standard
driver there really isn't a lot of interest on my part to help. Sorry.

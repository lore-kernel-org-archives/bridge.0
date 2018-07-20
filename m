Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=iE7upcieXpQG1uOR7DoVa2qbY5IYP2jBRWpM4ZszA4g=;
	b=xEt9PAfVwsKtPlE1A6dRcejpa+cssTTsSoryepaeZ/0tynrleRz8WFABkbPef6xYmL
	SlCOG3lfpDpgY4oYJr5AF0LniTp8ZNuiXxsqqda6pFqMZfH0tSnTl0gEMtXMn3ELBqni
	LwyNUT4qCsKU4gp35kBZtvrqfc4nxSQEiT3MG8MHs5YrT1/Bi5bQWgDbNpyf2hucuDkW
	CuICXewVDMIx/Rz1W4B5lbCUIWYsN89uEaj4HG9L20/gLDLR07gUqN1m6ryl9fbTSif0
	N5ZWUthOhcGoKWubJCcjhN71ta9/xihb65C/s8+YBb3XEHHmpyPNADQqUfb9cmW1FsRp
	+few==
Date: Fri, 20 Jul 2018 10:20:44 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20180720102044.16b92166@xeon-e3>
In-Reply-To: <8D6C03E0-6596-4B5B-9B6C-5684B5DFE148@cumulusnetworks.com>
References: <20180720144826.29892-1-nikolay@cumulusnetworks.com>
	<20180720144826.29892-2-nikolay@cumulusnetworks.com>
	<20180720085725.6dc1743d@xeon-e3>
	<8D6C03E0-6596-4B5B-9B6C-5684B5DFE148@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 1/2] net: bridge: add support for raw
 sysfs port options
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, wkok@cumulusnetworks.com, anuradhak@cumulusnetworks.com, davem@davemloft.net

On Fri, 20 Jul 2018 20:14:43 +0300
Nikolay Aleksandrov <nikolay@cumulusnetworks.com> wrote:

> >Casting away the const on the buf variable is going to cause warnings
> >and should not be necessary.
> >  
> 
> It doesn't when it's casted like that, the new line is changed to null byte so we need to drop 
> the const.

Then change store function to take a char *?
